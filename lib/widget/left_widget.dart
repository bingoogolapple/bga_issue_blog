import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/net/github_api.dart';
import 'package:bga_issue_blog/utils/config.dart';
import 'package:bga_issue_blog/utils/hex_color.dart';
import 'package:bga_issue_blog/utils/url_util.dart';
import 'package:bga_issue_blog/utils/ui_util.dart';
import 'package:bga_issue_blog/widget/common_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class LeftWidget extends StatefulWidget {
  LeftWidget({Key key}) : super(key: key);

  @override
  _LeftWidgetState createState() => _LeftWidgetState();
}

class _LeftWidgetState extends State<LeftWidget> {
  @override
  void initState() {
    super.initState();
    // 下一帧时再触发，以便拿到 context => 再通过  Provider.of<UserInfoModel> 拿 UserInfoModel
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _fetchUserInfo();
    });
  }

  _fetchUserInfo() {
    UserInfoModel userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    if (userInfoModel.userInfo != null) {
      return;
    }

    GitHubApi.getUserInfo().then((userInfo) {
      userInfoModel.userInfo = userInfo;
    }).catchError((error) {
      print('获取个人信息失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取个人信息失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(
            child: Consumer<UserInfoModel>(builder: (context, userInfoModel, _) {
              if (userInfoModel.userInfo == null) {
                return LoadingWidget();
              }
              return Column(
                children: [
                  ClipOval(
                    child: FadeInImage.memoryNetwork(width: 70, height: 70, placeholder: kTransparentImage, image: userInfoModel.userInfo.avatarUrl),
                  ),
                  SizedBox(height: 10),
                  Text(userInfoModel.userInfo.login),
                  SizedBox(height: 10),
                  Text(userInfoModel.userInfo.bio),
                ],
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Config.personalLinkMap.keys.map((imagePath) => buildImageLink(imagePath, Config.personalLinkMap[imagePath])).toList(),
          ),
          SizedBox(height: 30),
          buildMenuItem('个人博客', false),
          SizedBox(height: 10),
          buildMenuItem('关于我', true),
          SizedBox(height: 30),
          Text.rich(
            TextSpan(
              text: Config.qqTitle,
              style: TextStyle(color: HexColor('#4b595f')),
              children: [TextSpan(text: Config.qqDesc, style: TextStyle(color: HexColor('#849aa4')))],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Image.asset(
            Config.qqQrImg,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(Config.webSiteInfo, textAlign: TextAlign.center, style: TextStyle(color: HexColor('#849aa4'))),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: '主题 - ',
              style: TextStyle(color: HexColor('#849aa4')),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchURL(context, 'https://github.com/bingoogolapple/bga_issue_blog');
                    },
                  text: 'bga_issue_blog',
                  style: TextStyle(color: HexColor('#849aa4'), decoration: TextDecoration.underline),
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget buildImageLink(imagePath, url) {
    return SizedBox(
      width: 40,
      height: 40,
      child: RawMaterialButton(
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
          onPressed: () => launchURL(context, url)),
    );
  }

  Widget buildMenuItem(String title, bool isAboutMe) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Consumer<CheckedMenuModel>(
        child: Text(title),
        builder: (context, checkMenuModel, child) {
          bool checked = (checkMenuModel.isAboutMeChecked && isAboutMe) || (!checkMenuModel.isAboutMeChecked && !isAboutMe);
          return RawMaterialButton(
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
            child: child,
            onPressed: () {
              checkMenuModel.isAboutMeChecked = isAboutMe;
              // 手机风格时关闭 Drawer
              if (UIUtil.isPhoneStyle(context)) {
                Navigator.pop(context);
              }
            },
          );
        },
      ),
    );
  }
}
