import 'dart:js' as js;

launchURL(context, url) async {
  js.context.callMethod('open', [url]);
}
