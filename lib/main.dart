import 'package:bga_issue_blog/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bga_issue_blog/page/phone_home_page.dart';

void main() {
  // setErrorPage();
  runApp(BlogApp());
}

void setErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Scaffold(
      body: Center(child: Text("bga_issue_blog 开小差了,请重启 App！", style: TextStyle(fontSize: 20))),
    );
  };
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 跳转到其他页面后如果不想展示返回按钮，可以把 MaterialApp 再作为他页面的根 Widget
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bga_issue_blog',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
