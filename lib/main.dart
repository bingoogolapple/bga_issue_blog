import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/page/web_home_page.dart';
import 'package:bga_issue_blog/page/phone_home_page.dart';
import 'package:bga_issue_blog/utils/route_util.dart';
import 'package:bga_issue_blog/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  init();
  runApp(BlogApp());
}

void init() {
  RouteUtil.init();
//  setErrorPage();
}

void setErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Scaffold(
      body: Center(child: Text("bga_issue_blog 开小差了,请重启 App！", style: TextStyle(fontSize: 20))),
    );
  };
}

class BlogApp extends StatefulWidget {
  @override
  _BlogAppState createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => PageModel()),
        ChangeNotifierProvider(builder: (_) => KeywordModel()),
        ChangeNotifierProvider(builder: (_) => UserInfoModel()),
        ChangeNotifierProvider(builder: (_) => CheckedMenuModel()),
        ChangeNotifierProvider(builder: (_) => CurrentLabelModel()),
        ChangeNotifierProvider(builder: (_) => LabelListModel()),
        ChangeNotifierProvider(builder: (_) => IssueListModel()),
        ChangeNotifierProvider(builder: (_) => AboutMeModel()),
      ],
      // 跳转到其他页面后如果不想展示返回按钮，可以把 MaterialApp 再作为他页面的根 Widget
      child: MaterialApp(
        initialRoute: '/',
//        routes: {
//          '/blog':(context) => BlogDetailPage(),
//        },
        debugShowCheckedModeBanner: false,
        title: 'bga_issue_blog',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Flutter 默认支持横屏和竖屏，可以通过 SystemChrome.setPreferredOrientations 设置支持的屏幕方向，不能再 main 方法中设置
        // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        // 获取屏幕方向-方式一 OrientationBuilder 感知屏幕旋转
        // 获取屏幕方向-方式二 MediaQuery.of(context).orientation
        home: Stack(children: [
          AdaptiveWebInitHashWidget(),
          OrientationBuilder(
            builder: (context, orientation) {
              if (UIUtil.isPhoneStyle(context)) {
                return PhoneHomePage();
              } else {
                return WebHomePage();
              }
            },
          )
        ]),
      ),
    );
  }
}
