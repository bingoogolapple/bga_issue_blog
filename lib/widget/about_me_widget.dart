import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/markdown_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutMePage extends StatefulWidget {
  AboutMePage({Key key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  _fetchData() {
    AboutMeModel aboutMeModel = Provider.of<AboutMeModel>(context, listen: false);
    if (aboutMeModel.aboutMe != null) {
      return;
    }

    GitHubApi.getReadme().then((readme) {
      aboutMeModel.aboutMe = readme;
    }).catchError((error) {
      print('获取关于我信息失败 $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AboutMeModel>(builder: (context, aboutModel, _) {
      if (aboutModel.aboutMe == null) {
        return LoadingWidget();
      }
      return SingleChildScrollView(
          child: Padding(
        child: MarkdownWidget(markdown: aboutModel.aboutMe),
        padding: EdgeInsets.all(10),
      ));
    });
  }
}
