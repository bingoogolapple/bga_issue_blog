import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/issue_item.dart';
import 'package:flutter/material.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key key, @required this.currentLabel}) : super(key: key);

  final String currentLabel;

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends State<IssueList> {
  List _issueList;

  @override
  void initState() {
    super.initState();
    _fetchIssueList();
  }

  _fetchIssueList() async {
    GitHubApi.getIssueList(widget.currentLabel, '', 1, 20).then((data) {
      setState(() {
        _issueList = data;
      });
    }).catchError((error) {
      print('获取博客列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取博客列表失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_issueList == null) {
      return LoadingWidget();
    }
    if (_issueList.isEmpty) {
      return EmptyWidget('没有博客');
    }
    return ListView.builder(
        itemCount: _issueList.length,
        itemBuilder: (BuildContext context, int position) {
          return IssueItem(issue: _issueList[position]);
        });
  }
}
