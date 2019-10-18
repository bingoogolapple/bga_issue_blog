import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget getMarkdownView(BuildContext context, String markdown) {
  return Markdown(data: markdown);
}
