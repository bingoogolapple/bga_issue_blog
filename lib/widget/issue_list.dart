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
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchIssueList();
  }

  _fetchIssueList() {
    return GitHubApi.getIssueList(widget.currentLabel, '', _currentPage, 20).then((data) {
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
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: _issueList.length,
        itemBuilder: (BuildContext context, int position) {
          return IssueItem(issue: _issueList[position]);
        },
      ),
      onRefresh: _pullToRefresh,
    );
  }

  Future<Null> _pullToRefresh() async {
    _currentPage = 1;
    return await _fetchIssueList();
  }
}
