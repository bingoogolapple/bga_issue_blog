import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/utils/route_util.dart';
import 'package:bga_issue_blog/page/blog_detail_page.dart';
import 'package:bga_issue_blog/constants.dart';
import 'package:bga_issue_blog/utils/hexcolor.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _labelList = [];
  List _issueList = [];
  Map _userInfo = {};
  String _currentLabel;

  @override
  void initState() {
    super.initState();
    _fetchLabelList();
    _fetchIssueList();
  }

  _fetchLabelList() async {
    GitHubApi.getUserInfo().then((response) {
      setState(() {
        _userInfo = response[0];
        _labelList = response[1];
      });
    }).catchError((error) {
      print('获取标签失败 $error');
    });
  }

  _fetchIssueList() async {
    GitHubApi.getIssueList(_currentLabel, '', 1, 20).then((data) {
      setState(() {
        _issueList = data;
      });
    }).catchError((error) {
      print('获取 Issue 失败 $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.gitHubUsername),
      ),
      body: Row(
        children: <Widget>[
          Expanded(flex: 1, child: initLabelList()),
          Expanded(flex: 3, child: initIssueList()),
        ],
      ),
    );
  }

  Widget initLabelList() {
    if (_labelList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _labelList.length,
        itemBuilder: (BuildContext context, int position) {
          return getLabelRow(position);
        });
  }

  Widget initIssueList() {
    if (_issueList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _issueList.length,
        itemBuilder: (BuildContext context, int position) {
          return getIssueRow(position);
        });
  }

  Widget getLabelRow(int position) {
    final label = _labelList[position];
    final selected = label['name'] == _currentLabel;
    return ActionChip(
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: selected ? 20 : 14,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        fontStyle: selected ? FontStyle.italic : FontStyle.normal,
      ),
      label: Text(label['name']),
      backgroundColor: HexColor(label['color']),
      onPressed: () {
        setState(() {
          _currentLabel = label['name'];
          _fetchIssueList();
        });
      },
    );
  }

  Widget getIssueRow(int position) {
    final issue = _issueList[position];
    return Container(
      child: ListTile(
        title: GestureDetector(
          child: Text(issue['title']),
          onTap: () => RouteUtil.routeWithFadeTransition(context, BlogDetailPage(number: issue['number'])),
        ),
        trailing: Text(DateTime.tryParse(issue['created_at']).toString().substring(0, "yyyy-MM-dd HH:mm".length)),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
      ),
    );
  }
}
