import 'dart:async';

import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/issue_item.dart';
import 'package:flutter/material.dart';
import 'package:bga_issue_blog/utils/events.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key key}) : super(key: key);

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends BaseState<IssueList> {
  List _issueList;
  int _page = 1;
  String _keyword = '';
  String _currentLabel;

  @override
  void initState() {
    super.initState();

    callbackBus.on(event_keyword_changed, onKeywordChanged);
    callbackBus.on(event_page_changed, onPageChanged);

    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _currentLabel = event.label;
      _keyword = '';
      _page = 1;
      _fetchIssueList();
    }));

    _fetchIssueList();
  }

  @override
  void dispose() {
    callbackBus.off(event_keyword_changed, onKeywordChanged);
    callbackBus.off(event_page_changed, onPageChanged);
    super.dispose();
  }

  void onKeywordChanged(newKeyword) {
    _keyword = newKeyword;
    _fetchIssueList();
  }

  void onPageChanged(newPage) {
    _page = newPage;
    _fetchIssueList();
  }

  _fetchIssueList() {
    return GitHubApi.getIssueList(_currentLabel, _keyword, _page, 20).then((data) {
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
      onRefresh: _pullToRefresh,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _issueList.length,
          itemBuilder: (BuildContext context, int position) {
            return IssueItem(issue: _issueList[position]);
          },
        ),
      ),
    );
  }

  Future<Null> _pullToRefresh() async {
    _page = 1;
    return await _fetchIssueList();
  }
}
