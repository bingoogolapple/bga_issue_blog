import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/utils/constants.dart';
import 'package:bga_issue_blog/widget/about_me_widget.dart';
import 'package:bga_issue_blog/widget/issue_list.dart';
import 'package:bga_issue_blog/widget/label_list.dart';
import 'package:bga_issue_blog/widget/left_widget.dart';
import 'package:bga_issue_blog/widget/page_widget.dart';
import 'package:bga_issue_blog/widget/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.gitHubUsername),
        backgroundColor: Colors.lightGreen,
      ),
      body: Row(
        children: <Widget>[
          Expanded(flex: 1, child: LeftWidget()),
          VerticalDivider(width: 1),
          Expanded(flex: 3, child: _buildRightWidget()),
        ],
      ),
    );
  }

  Widget _buildRightWidget() {
    return Consumer<CheckedMenuModel>(builder: (context, checkedMenuModel, child) {
      if (checkedMenuModel.isAboutMeChecked) {
        return AboutMePage();
      }
      return Column(
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
    });
  }
}
