import 'package:bga_issue_blog/datatransfer/app_model.dart';
import 'package:bga_issue_blog/datatransfer/app_model_change_notification.dart';
import 'package:bga_issue_blog/datatransfer/app_provider.dart';
import 'package:bga_issue_blog/utils/constants.dart';
import 'package:bga_issue_blog/widget/about_me_widget.dart';
import 'package:bga_issue_blog/widget/issue_list.dart';
import 'package:bga_issue_blog/widget/label_list.dart';
import 'package:bga_issue_blog/widget/left_widget.dart';
import 'package:bga_issue_blog/widget/page_widget.dart';
import 'package:bga_issue_blog/widget/search_widget.dart';

import 'package:flutter/material.dart';

class WebHomePage extends StatefulWidget {
  WebHomePage({Key key}) : super(key: key);

  @override
  _WebHomePageState createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  AppModel _appModel = AppModel();

  @override
  Widget build(BuildContext context) {
    Widget rightWidget;
    if (_appModel.isAboutMeChecked) {
      rightWidget = AboutMePage();
    } else {
      rightWidget = Column(
        children: [
          LabelList(),
          Divider(),
          Expanded(child: IssueList()),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SearchWidget(),
                ),
                SizedBox(width: 20),
                PageWidget(),
              ],
            ),
          ),
        ],
      );
    }
    return NotificationListener<AppModelChangedNotification>(
      onNotification: (AppModelChangedNotification notification) {
        setState(() {});
        return false;
      },
      child: AppProvider(
        model: _appModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constants.gitHubUsername),
            backgroundColor: Colors.lightGreen,
          ),
          body: Row(
            children: <Widget>[
              Expanded(flex: 1, child: LeftWidget()),
              VerticalDivider(width: 1),
              Expanded(flex: 3, child: rightWidget),
            ],
          ),
        ),
      ),
    );
  }
}
