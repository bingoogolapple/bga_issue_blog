import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/datatransfer/events.dart';
import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key key}) : super(key: key);

  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends BaseState<SearchWidget> {
  TextEditingController _keywordController;
  FocusNode _focusNode;

  _SearchWidgetState() {
    _keywordController = addAndGetChangeNotifier(TextEditingController(text: ''));
    _focusNode = addAndGetChangeNotifier(FocusNode());
  }

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

    /// 手机上按回车键时是先触发 TextField.onEditingComplete 再触发 TextField.onSubmitted，不会触发 RawKeyboardListener.onKey
    /// Web 上按回车键时只会触发 RawKeyboardListener，不会触发 TextField.onEditingComplete 和 TextField.onSubmitted
    /// 保险起见还是过滤一下 event.data is RawKeyEventDataWeb
    /// 不包裹 RawKeyboardListener，直接监听 TextField.focusNode.onKey 也可以
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyUpEvent && event.data.logicalKey == LogicalKeyboardKey.enter && event.data is RawKeyEventDataWeb) {
          _handleClickEnter();
        }
      },
      child: TextField(
        controller: _keywordController,
        textInputAction: TextInputAction.search,
        onSubmitted: (text) => _handleClickEnter(),
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
            onPressed: _handleClickEnter,
          ),
        ),
      ),
    );
  }

  void _handleClickEnter() {
    _focusNode.unfocus();
    // 保存 keyword
    _saveKeyword();
    streamBus.emit(KeywordChangedEvent(_keywordController.text));
  }

  void _saveKeyword() {
    Provider.of<KeywordModel>(context, listen: false).keyword = _keywordController.text;
  }
}
