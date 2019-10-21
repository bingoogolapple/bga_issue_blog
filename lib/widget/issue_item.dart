import 'package:bga_issue_blog/page/blog_detail_page.dart';
import 'package:bga_issue_blog/utils/route_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({Key key, this.issue}) : super(key: key);

  final issue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: _buildTitle(context),
        trailing: Text(DateTime.tryParse(issue['created_at']).toString().substring(0, "yyyy-MM-dd HH:mm".length)),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    // Web 还不支持选择复制，Android、iOS 可以，但点击空白区域时，拷贝、全选浮窗不会自动消失
    if (kIsWeb) {
      return GestureDetector(
        child: Text(issue['title']),
//        onTap: () => RouteUtil.pushWithSwipeBackTransition(context, BlogDetailPage(number: issue['number'])),
//        onTap: () => Navigator.pushNamed(context, '/blog', arguments: issue['number']),
        onTap: () => RouteUtil.routeToBlogDetail(context, issue['number']),
      );
    }
    return GestureDetector(
      child: SelectableText(
        issue['title'],
        onTap: () => RouteUtil.routeToBlogDetail(context, issue['number']),
        toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
      ),
    );
  }
}
