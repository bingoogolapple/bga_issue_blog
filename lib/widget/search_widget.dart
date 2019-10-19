import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/utils/events.dart';
import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key key}) : super(key: key);

  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends BaseState<SearchWidget> {
  final _keywordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 恢复 keyword 数据
      _keywordController.text = Provider.of<KeywordModel>(context, listen: false).keyword;
    });
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _keywordController.text = '';
      // 保存 keyword
      _saveKeyword();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(const Radius.circular(30)),
      borderSide: BorderSide(color: HexColor('#eeeeee')),
    );
    return TextField(
      controller: _keywordController,
      textInputAction: TextInputAction.search,
      onSubmitted: (text) {
        callbackBus.emit(event_keyword_changed, text);
      },
      style: TextStyle(fontSize: 14, color: HexColor('#4b595f')),
      decoration: InputDecoration(
        hintText: '按文章标题或内容搜索...',
        hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: HexColor('#849aa4')),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // 保存 keyword
            _saveKeyword();
            callbackBus.emit(event_keyword_changed, _keywordController.text);
          },
        ),
      ),
    );
  }

  void _saveKeyword() {
    Provider.of<KeywordModel>(context, listen: false).keyword = _keywordController.text;
  }
}
