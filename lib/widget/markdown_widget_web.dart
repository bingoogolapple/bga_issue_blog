import 'package:bga_issue_blog/utils/url_util.dart';
import 'package:flutter/widgets.dart';
import 'package:markdown/markdown.dart' as mk;
import 'package:flutter_html/flutter_html.dart';

Widget getMarkdownView(BuildContext context, String markdown) {
  return SingleChildScrollView(
    child: Html(
      data: mk.markdownToHtml(markdown, extensionSet: mk.ExtensionSet.gitHubWeb),
      renderNewlines: true,
      onLinkTap: (url) {
        launchURL(context, url);
      },
      onImageTap: (url) {
        launchURL(context, url);
      },
    ),
  );
}
