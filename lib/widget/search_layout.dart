import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/utils/events.dart';
import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:bga_issue_blog/widget/page_layout.dart';
import 'package:flutter/material.dart';

class SearchLayout extends StatefulWidget {
  SearchLayout({Key key}) : super(key: key);

  _SearchLayoutState createState() => _SearchLayoutState();
}

class _SearchLayoutState extends BaseState<SearchLayout> {
  final _keywordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _keywordController.text = '';
    }));
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(color: HexColor('#eeeeee')),
    );
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _keywordController,
                textInputAction: TextInputAction.search,
                onSubmitted: (text) {
                  callbackBus.emit(event_keyword_changed, text);
                },
                style: TextStyle(fontSize: 14, color: HexColor('#4b595f')),
                decoration: InputDecoration(
                  hintText: '按文章标题或内容搜索...',
                  hintStyle: TextStyle(fontSize: 14, color: HexColor('#849aa4')),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  suffixIcon: Image.asset("images/enter-icon.svg"),
                ),
              ),
            ),
            SizedBox(width: 10),
            PageLayout(),
          ],
        ));
  }
}
