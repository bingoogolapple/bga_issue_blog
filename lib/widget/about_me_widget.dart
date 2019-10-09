import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/markdown_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  AboutMePage({Key key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String _readme;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() {
    GitHubApi.getReadme().then((readme) {
      setState(() {
        _readme = readme;
      });
    }).catchError((error) {
      print('获取关于我信息失败 $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_readme == null) {
      return LoadingWidget();
    }
    return SingleChildScrollView(
        child: Padding(
      child: MarkdownWidget(markdown: _readme),
      padding: EdgeInsets.all(10),
    ));
  }
}
