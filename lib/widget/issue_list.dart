import 'dart:async';

import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/issue_item.dart';
import 'package:flutter/material.dart';
import 'package:bga_issue_blog/datatransfer/events.dart';
import 'package:provider/provider.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key key}) : super(key: key);

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends BaseState<IssueList> {
  ScrollController _scrollController = new ScrollController();
  bool _isLoadingMore = false;

  PageModel _pageModel;
  int _page = 1;

  KeywordModel _keywordModel;
  String _keyword = '';

  CurrentLabelModel _currentLabelModel;

  IssueListModel _issueListModel;

  @override
  void initState() {
    super.initState();

    addSubscription(streamBus.on<PageChangedEvent>().listen((event) {
      if (_page == event.page) {
        return;
      }
      _page = event.page;
      _fetchIssueList();
    }));

    addSubscription(streamBus.on<KeywordChangedEvent>().listen((event) {
      if (_keyword == event.keyword) {
        return;
      }
      _keyword = event.keyword;
      _pullToRefresh();
    }));

    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _keyword = '';
      _page = 1;
      _fetchIssueList();
    }));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent || _isLoadingMore) {
        return;
      }
      _loadMore();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 恢复 label 数据
      _currentLabelModel = Provider.of<CurrentLabelModel>(context, listen: false);

      // 恢复 keyword 数据
      _keywordModel = Provider.of<KeywordModel>(context, listen: false);
      _keyword = _keywordModel.keyword;

      // 恢复 page 数据
      _pageModel = Provider.of<PageModel>(context, listen: false);
      _page = _pageModel.page;

      // 恢复 issueList
      _issueListModel = Provider.of<IssueListModel>(context, listen: false);
      if (_issueListModel.issueList != null) {
        return;
      }
      _fetchIssueList();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    _isLoadingMore = true;
    setState(() {});
    // 加载更多更新页码
    _page++;
    _pageModel.page = _page;
    _fetchIssueList();
  }

  Future<Null> _fetchIssueList() {
    return GitHubApi.getIssueList(_currentLabelModel.currentLabel, _keyword, _page, 20).then((data) {
      if (_isLoadingMore) {
        _issueListModel.addMoreIssueList(data);
      } else {
        _issueListModel.issueList = data;
      }
    }).catchError((error) {
      print('获取博客列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取博客列表失败')));
    }).whenComplete(() {
      _isLoadingMore = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssueListModel>(builder: (context, issueListModel, _) {
      if (issueListModel.issueList == null) {
        return LoadingWidget();
      }
      if (issueListModel.issueList.isEmpty) {
        return EmptyWidget('没有博客');
      }
      return RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: Scrollbar(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: issueListModel.issueList.length + 1,
            itemBuilder: (BuildContext context, int position) {
              if (position == issueListModel.issueList.length) {
                return _buildLoadMoreWidget();
              }
              return IssueItem(issue: issueListModel.issueList[position]);
            },
          ),
        ),
      );
    });
  }

  Widget _buildLoadMoreWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Opacity(
        opacity: _isLoadingMore ? 1.0 : 0.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<Null> _pullToRefresh() async {
    // 下拉刷新时更新当前页码
    _page = 1;
    _pageModel.page = _page;
    return await _fetchIssueList();
  }
}
