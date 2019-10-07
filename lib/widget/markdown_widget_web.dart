import 'package:flutter/widgets.dart';
import 'package:markdown/markdown.dart' as mk;
import 'package:flutter_html/flutter_html.dart';

Widget getMarkdownView(String markdown) {
  return SingleChildScrollView(child: Html(data: mk.markdownToHtml(markdown)));
}
