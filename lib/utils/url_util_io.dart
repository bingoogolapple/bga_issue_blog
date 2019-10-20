import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(context, url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('链接无效 $url')));
  }
}

getUrl() {
  return null;
}

getUrlHash() {
  return null;
}