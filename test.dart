import 'dart:async';


main(){

  var uri = 'http://example.org/api?foo=a+ b';
  var encoded = Uri.encodeFull(uri);
  print(encoded);
  assert(encoded == 'http://example.org/api?foo=some%20message');

  var decoded = Uri.decodeFull(encoded);
  assert(uri == decoded);
  print(decoded);
}