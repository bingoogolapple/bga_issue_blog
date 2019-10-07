import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/comment_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatefulWidget {
  BlogDetailPage({Key key, this.number}) : super(key: key);
  final int number;

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  Map _issue;
  List _comments;

  @override
  void initState() {
    super.initState();
    _fetchIssue();
  }

  _fetchIssue() async {
    GitHubApi.getIssue(widget.number).then((issue) {
      setState(() {
        _issue = issue;
        _fetchComments();
      });
    }).catchError((error) {
      print('获取 issue 失败 $error');
    });
  }

  _fetchComments() async {
    if (_issue != null && this._issue['comments'] > 0) {
      GitHubApi.getComments(_issue['comments_url']).then((comments) {
        setState(() {
          _comments = comments;
        });
      }).catchError((error) {
        print('获取 comments 失败 $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_issue == null ? '博客详情' : _issue['title']),
          backgroundColor: Colors.lightBlue,
        ),
        body: buildBodyWidget);
  }

  Widget get buildBodyWidget {
    if (_issue == null) {
      return Center(child: CircularProgressIndicator());
    }
    List<Widget> commentWidgetList = [CommentWidget(comment: _issue)];
    if (_comments != null && _comments.isNotEmpty) {
      for (Map comment in _comments) {
        commentWidgetList.add(CommentWidget(comment: comment));
      }
    }
    return ListView(children: commentWidgetList);
  }
}
