import 'package:bga_issue_blog/dto/user_info.dart';
import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/utils/hexcolor.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class LeftWidget extends StatefulWidget {
  LeftWidget({Key key}) : super(key: key);

  @override
  _LeftWidgetState createState() => _LeftWidgetState();
}

class _LeftWidgetState extends State<LeftWidget> {
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  _fetchUserInfo() {
    GitHubApi.getUserInfo().then((userInfo) {
      setState(() {
        _userInfo = userInfo;
      });
    }).catchError((error) {
      print('获取个人信息失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取个人信息失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo == null) {
      return LoadingWidget();
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 10),
        ClipOval(child: FadeInImage.memoryNetwork(width: 70, placeholder: kTransparentImage, image: _userInfo.avatarUrl)),
        SizedBox(height: 10),
        Text(_userInfo.login),
        SizedBox(height: 10),
        Text(_userInfo.bio),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/github.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Image.asset(
              'images/git.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            )
          ],
        ),
        SizedBox(height: 30),
        buildMenuItem('个人博客', true),
        SizedBox(height: 10),
        buildMenuItem('关于我', false),
        SizedBox(height: 30),
        Text.rich(
          TextSpan(
            text: 'BGA 系列\n',
            style: TextStyle(color: HexColor('#4b595f')),
            children: [TextSpan(text: '开源库 QQ 群', style: TextStyle(color: HexColor('#849aa4')))],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Image.asset(
          'images/qq-group.png',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        Text('©2014 - ${DateTime.now().year} bingoogolapple\n蜀ICP备17023604号', textAlign: TextAlign.center, style: TextStyle(color: HexColor('#849aa4'))),
        SizedBox(height: 10),
        Text('主题 - bga_issue_blog', style: TextStyle(color: HexColor('#849aa4'))),
        SizedBox(height: 50),
      ],
    ));
  }

  Widget buildMenuItem(String title, bool checked) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: RawMaterialButton(
        hoverColor: HexColor('#e5f1fc'),
        highlightColor: HexColor('#e5f1fc'),
        fillColor: checked ? HexColor('#e5f1fc') : Colors.transparent,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        padding: EdgeInsets.all(15),
        textStyle: TextStyle(
          color: checked ? HexColor('#3593f2') : HexColor('#4b595f'),
          fontSize: 16,
          fontWeight: checked ? FontWeight.bold : FontWeight.normal,
        ),
        shape: Border(left: BorderSide(color: HexColor('#3593f2'), width: 4)),
        child: Text(title),
        onPressed: () {
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('点击了$title')));
        },
      ),
    );
  }
}
