import 'package:bga_issue_blog/page/blog_detail_page.dart';
import 'package:bga_issue_blog/utils/route_util.dart';
import 'package:flutter/material.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({Key key, this.issue}) : super(key: key);

  final issue;

  @override
  Widget build(BuildContext context) {
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
