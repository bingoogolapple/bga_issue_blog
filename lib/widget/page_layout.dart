import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  PageLayout({Key key, @required this.onPageChanged}) : super(key: key);

  final ValueChanged onPageChanged;

  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  final _pageController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {});
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
              _pageController.text = '$page';
              widget.onPageChanged(page);
            }),
        SizedBox(width: 10),
        SizedBox(
            width: 60,
            child: TextField(
              controller: _pageController,
              textInputAction: TextInputAction.search,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                int page = int.tryParse(_pageController.text);
                if (page == null || page <= 0) {
                  page = 1;
                  _pageController.text = '$page';
                }
                widget.onPageChanged(page);
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
            )),
        SizedBox(width: 10),
        GestureDetector(
            child: Image.asset('images/next-page-hover.png'),
            onTap: () {
              int page = int.tryParse(_pageController.text);
              if (page == null || page < 0) {
                page = 0;
              }
              page++;
              _pageController.text = '$page';
              widget.onPageChanged(page);
            }),
      ],
    );
  }
}
