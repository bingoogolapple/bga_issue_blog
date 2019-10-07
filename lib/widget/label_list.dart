import 'package:bga_issue_blog/dto/label.dart';
import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:bga_issue_blog/widget/label_item.dart';
import 'package:flutter/material.dart';

class LabelList extends StatefulWidget {
  const LabelList({Key key, @required this.onLabelChanged}) : super(key: key);

  final ValueChanged<String> onLabelChanged;

  @override
  _LabelListState createState() => _LabelListState();
}

class _LabelListState extends State<LabelList> {
  List<Label> _labelList;
  String _currentLabel;

  @override
  void initState() {
    super.initState();
    _fetchLabelList();
  }

  _fetchLabelList() async {
    GitHubApi.getLabelList().then((labelList) {
      setState(() {
        _labelList = labelList;
      });
    }).catchError((error) {
      print('获取标签列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取标签列表失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_labelList == null) {
      return LoadingWidget();
    }
    if (_labelList.isEmpty) {
      return EmptyWidget('没有分类');
    }
    return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: _labelList.map((label) {
          return LabelItem(
            label: label,
            selected: label.name == _currentLabel,
            onSelected: (selected) {
              setState(() {
                _currentLabel = selected ? label.name : null;
              });
              widget.onLabelChanged(_currentLabel);
            },
          );
        }).toList());
  }
}
