import 'package:bga_issue_blog/widget/markdown_widget.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key key, @required this.comment}) : super(key: key);

  final Map comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment['user']['avatar_url']),
              ),
              title: Text(comment['user']['login']),
              trailing: Text(DateTime.tryParse(comment['created_at']).toString().substring(0, "yyyy-MM-dd HH:mm".length)),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 250, 252),
              border: Border(bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
            ),
          ),
          Padding(
            child: MarkdownWidget(markdown: comment['body']),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
