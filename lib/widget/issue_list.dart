import 'dart:async';

import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/issue_item.dart';
import 'package:flutter/material.dart';
import 'package:bga_issue_blog/utils/events.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key key}) : super(key: key);

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends State<IssueList> {
  List _issueList;
  int _currentPage = 1;
  String _currentLabel;
  StreamSubscription _labelSubscription;

  @override
  void initState() {
    super.initState();

//    callbackBus.on(event_label_changed, onLabelChanged);

    _labelSubscription = streamBus.on<LabelChangedEvent>().listen((event) {
      _currentLabel = event.label;
      _fetchIssueList();
    });

    _fetchIssueList();
  }

  @override
  void dispose() {
//    callbackBus.off(event_label_changed, onLabelChanged);

    if (_labelSubscription != null) {
      _labelSubscription.cancel();
    }
    super.dispose();
  }

  void onLabelChanged(newLabel) {
    _currentLabel = newLabel;
    _fetchIssueList();
  }

  _fetchIssueList() {
    return GitHubApi.getIssueList(_currentLabel, '', _currentPage, 20).then((data) {
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
