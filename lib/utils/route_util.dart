import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RouteUtil {
  static routeWithFadeTransition(BuildContext context, Widget page) {
    // 使用 CupertinoPageRoute 支持滑动返回
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return page;
    }));
//    Navigator.of(context).push(PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return page;
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return _transition(animation, child);
//        }));
  }

  static FadeTransition _transition(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: child,
      ),
    );
  }
}
