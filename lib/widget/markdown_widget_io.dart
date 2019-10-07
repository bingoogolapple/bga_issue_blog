import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget getMarkdownView(String markdown) {
  return Markdown(data: markdown);
}
