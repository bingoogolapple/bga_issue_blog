import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/utils/events.dart';
import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageWidget extends StatefulWidget {
  PageWidget({Key key}) : super(key: key);

  _PageWidgetState createState() => _PageWidgetState();
}

class _PageWidgetState extends BaseState<PageWidget> {
  final _pageController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _pageController.text = '1';
      // 保存 page
      _savePage();
    }));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(color: HexColor('#eeeeee')),
    );
    return Row(
      children: [
        GestureDetector(
            child: Image.asset('images/pre-page-hover.png'),
            onTap: () {
              int page = int.tryParse(_pageController.text);
              if (page == null || page <= 1) {
                page = 2;
              }
              page--;
              _pageController.text = page.toString();
              notifyPageChanged(page);
            }),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Consumer<PageModel>(builder: (context, pageModel, _) {
            _pageController.text = pageModel.page.toString();
            return TextField(
              controller: _pageController,
              textInputAction: TextInputAction.search,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              // 在 Web 上不好使
              onSubmitted: (text) {
                int page = int.tryParse(_pageController.text);
                if (page == null || page <= 0) {
                  page = 1;
                  _pageController.text = page.toString();
                }
                notifyPageChanged(page);
              },
              style: TextStyle(fontSize: 14, color: HexColor('#4b595f')),
              decoration: InputDecoration(
                hintText: '页码',
                hintStyle: TextStyle(fontSize: 14, color: HexColor('#849aa4')),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
            );
          }),
        ),
        SizedBox(width: 10),
        GestureDetector(
            child: Image.asset('images/next-page-hover.png'),
            onTap: () {
              int page = int.tryParse(_pageController.text);
              if (page == null || page < 0) {
                page = 0;
              }
              page++;
              _pageController.text = page.toString();
              notifyPageChanged(page);
            }),
      ],
    );
  }

  void notifyPageChanged(page) {
    // 保存 page
    _savePage();
    callbackBus.emit(event_page_changed, page);
  }

  void _savePage() {
    Provider.of<PageModel>(context, listen: false).page = int.tryParse(_pageController.text);
  }
}
