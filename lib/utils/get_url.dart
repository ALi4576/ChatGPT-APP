import 'dart:html';

String getUrl() {
  var url = window.location.href;
  var refinedUrl = url.split(':');
  url = '${refinedUrl[0]}:${refinedUrl[1]}:9999/';
  print(url);
  return url;
}
