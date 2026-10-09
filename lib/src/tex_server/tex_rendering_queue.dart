import 'dart:async';
import 'package:flutter_tex/flutter_tex.dart';

/// A handle to a rendering request that allows cancellation.
class TexRenderingRequest {
  final Future<String> future;
  final void Function() cancel;

  TexRenderingRequest({required this.future, required this.cancel});
}

/// A generic LIFO (Last-In-First-Out) queue to manage TeX rendering requests.
///
/// This specific queuing strategy is optimized for UI performance (e.g., scrolling lists):
/// 1. **Concurrency Control**: Limits the number of active renderings to avoid blocking the JavaScript bridge or UI thread.
/// 2. **LIFO Order**: Prioritizes the *most recent* request. When a user scrolls quickly, we want to render the items currently valid on screen (the newest ones), rather than clearing a backlog of items that have already scrolled off-screen.
class TexRenderingQueue {
  final int maxConcurrentRequests;
  final List<_MathRequest> _queue = [];
  int _activeRequests = 0;

  /// Creates a queue with a strict limit on [maxConcurrentRequests].
  TexRenderingQueue({this.maxConcurrentRequests = 10});

  /// Adds a new rendering task to the queue with cancellation support.
  ///
  /// - [processor]: An async callback that performs the actual rendering work (e.g., calling a JS function).
  ///
  /// Returns a [TexRenderingRequest] containing the result [Future] and a [cancel] method.
  /// If [cancel] is called before the task starts processing, the task is removed from the queue.
  TexRenderingRequest addRequest({
    required String math,
    required MathInputType inputType,
    required Future<String> Function() processor,
  }) {
    final completer = Completer<String>();
    final request = _MathRequest(math, inputType, completer, processor);

    // Prioritize newer requests to render content currently visible on screen.
    _queue.insert(0, request);
    _processQueue();

    return TexRenderingRequest(
      future: completer.future,
      cancel: () {
        if (_queue.remove(request) && !completer.isCompleted) {
          completer.completeError("Cancelled");
        }
      },
    );
  }

  /// Processes the queue items respecting the concurrency limit.
  void _processQueue() async {
    if (_activeRequests >= maxConcurrentRequests || _queue.isEmpty) return;

    _activeRequests++;
    final request = _queue.removeAt(0);

    try {
      final result = await request.processor();
      if (!request.completer.isCompleted) {
        request.completer.complete(result);
      }
    } catch (e) {
      if (!request.completer.isCompleted) {
        request.completer.completeError(e);
      }
    } finally {
      _activeRequests--;
      _processQueue(); // Process the next item
    }
  }
}

class _MathRequest {
  final String math;
  final MathInputType inputType;
  final Completer<String> completer;
  final Future<String> Function() processor;

  _MathRequest(this.math, this.inputType, this.completer, this.processor);
}
