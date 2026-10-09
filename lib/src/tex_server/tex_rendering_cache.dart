import 'dart:async';
import 'dart:collection';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/tex_server/tex_rendering_queue.dart';

/// Tracks active rendering requests and their listener counts for deduplication.
class _SharedRenderingRequest {
  final TexRenderingRequest request;
  int refCount;

  _SharedRenderingRequest(this.request, this.refCount);
}

/// In-memory LRU cache and in-flight request deduplicator for rendered TeX SVGs.
class TexRenderingCache {
  /// Maximum number of rendered SVGs retained in memory.
  static const int _maxCacheSize = 100;

  /// LRU cache storing rendered SVG strings keyed by syntax type and formula.
  static final LinkedHashMap<String, String> _svgCache =
      LinkedHashMap<String, String>();

  /// In-flight rendering requests tracked with reference counts.
  static final Map<String, _SharedRenderingRequest> _inFlightRequests = {};

  /// Returns a previously rendered SVG from cache if present.
  static String? getCachedSVG(String math, MathInputType type) {
    return _svgCache['${type.type}_$math'];
  }

  /// Stores a rendered SVG in the cache, evicting the oldest entry when exceeding [_maxCacheSize].
  static void updateCache(String key, String value) {
    if (_svgCache.length >= _maxCacheSize) {
      _svgCache.remove(_svgCache.keys.first);
    }
    _svgCache[key] = value;
  }

  /// Manages rendering by querying the cache, deduplicating in-flight tasks,
  /// or creating a new request via [onMissing].
  ///
  /// Returns a [TexRenderingRequest] handle with reference-counted cancellation.
  static TexRenderingRequest render({
    required String math,
    required MathInputType mathInputType,
    required TexRenderingRequest Function() onMissing,
  }) {
    final cacheKey = '${mathInputType.type}_$math';

    final cachedResult = _svgCache[cacheKey];
    if (cachedResult != null) {
      return TexRenderingRequest(
        future: Future.value(cachedResult),
        cancel: () {},
      );
    }

    final inFlight = _inFlightRequests[cacheKey];
    if (inFlight != null) {
      inFlight.refCount++;
      bool isCancelled = false;

      return TexRenderingRequest(
        future: inFlight.request.future,
        cancel: () {
          if (isCancelled) return;
          isCancelled = true;
          inFlight.refCount--;
          if (inFlight.refCount <= 0) {
            inFlight.request.cancel();
            _inFlightRequests.remove(cacheKey);
          }
        },
      );
    }

    final originalRequest = onMissing();

    final cachingFuture = originalRequest.future.then((result) {
      if (result.isNotEmpty && result != "null") {
        updateCache(cacheKey, result);
        return result;
      }
      throw "Render failed or returned empty/null";
    }).whenComplete(() {
      _inFlightRequests.remove(cacheKey);
    });

    final wrappedRequest = TexRenderingRequest(
      future: cachingFuture,
      cancel: originalRequest.cancel,
    );

    _inFlightRequests[cacheKey] = _SharedRenderingRequest(wrappedRequest, 1);

    bool isCancelled = false;
    return TexRenderingRequest(
      future: cachingFuture,
      cancel: () {
        if (isCancelled) return;
        isCancelled = true;
        final sharedReq = _inFlightRequests[cacheKey];
        if (sharedReq != null) {
          sharedReq.refCount--;
          if (sharedReq.refCount <= 0) {
            sharedReq.request.cancel();
            _inFlightRequests.remove(cacheKey);
          }
        }
      },
    );
  }
}
