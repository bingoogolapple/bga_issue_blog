import 'package:bga_issue_blog/dto/label.dart';
import 'package:bga_issue_blog/utils/hexcolor.dart';
import 'package:flutter/material.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({Key key, this.label, this.selected, this.onSelected}) : super(key: key);

  final Label label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: selected ? 18 : 14,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        fontStyle: selected ? FontStyle.italic : FontStyle.normal,
      ),
      label: Text(label.name),
      backgroundColor: HexColor(label.color),
      selected: selected,
      onSelected: onSelected,
    );
  }
}
