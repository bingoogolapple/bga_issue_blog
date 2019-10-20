import 'dart:js' as js;
import 'dart:html' as html;

launchURL(context, url) async {
  // 当前页面打开
//  html.document.window.location.href = url;
  // 新页面打开
  js.context.callMethod('open', [url]);
}

String getUrl() {
  return html.document.window.location.toString();
}

String getUrlHash() {
  var url = getUrl();
  if (url == null || !url.contains('#/')) {
    return null;
  }
  return url.substring(url.indexOf('#/') + 1);
}

//updateUrl(url) {
//  html.window.history.pushState('data', 'title', '#/$url');
//}
