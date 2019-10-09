import 'package:bga_issue_blog/utils/constants.dart';
import 'package:bga_issue_blog/widget/about_me_widget.dart';
import 'package:bga_issue_blog/widget/issue_list.dart';
import 'package:bga_issue_blog/widget/label_list.dart';
import 'package:bga_issue_blog/widget/left_widget.dart';
import 'package:bga_issue_blog/widget/search_layout.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAboutMeChecked = false;

  @override
  Widget build(BuildContext context) {
    Widget rightWidget;
    if (_isAboutMeChecked) {
      rightWidget = AboutMePage();
    } else {
      rightWidget = Column(
        children: [
          LabelList(),
          Divider(),
          Expanded(child: IssueList()),
          SearchLayout(),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.gitHubUsername),
        backgroundColor: Colors.lightGreen,
      ),
      body: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: LeftWidget(
                  isAboutMeChecked: _isAboutMeChecked,
                  onShowReadMeChanged: (isAboutMeChecked) {
                    setState(() {
                      _isAboutMeChecked = isAboutMeChecked;
                    });
                  })),
          VerticalDivider(width: 1),
          Expanded(flex: 3, child: rightWidget),
        ],
      ),
    );
  }
}
