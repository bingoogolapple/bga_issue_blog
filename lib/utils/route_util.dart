import 'package:bga_issue_blog/page/blog_detail_page.dart';
import 'package:bga_issue_blog/utils/url_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RouteUtil {
  static final _router = Router();
  static String _initHashRoute;

  static init() {
    _router.define('/blog/:number', handler: Handler(handlerFunc: (context, params) {
      return BlogDetailPage(number: params['number'][0]);
    }), transitionType: TransitionType.cupertino);

    final String urlHash = getUrlHash();
    if (urlHash == null || urlHash.isEmpty || urlHash == '/') {
      return;
    }
    _initHashRoute = urlHash;
  }

  // 跳转到浏览器路由 hash
  static handleGoInitHashRoute(BuildContext context) {
    if (_initHashRoute == null) {
      return;
    }
    _router.navigateTo(context, _initHashRoute);
    _initHashRoute = null;
  }

  static routeToBlogDetail(context, number) {
    _router.navigateTo(context, '/blog/$number');
  }

//  static pushWithSwipeBackTransition(BuildContext context, Widget page) {
//    // 使用 CupertinoPageRoute 支持滑动返回
//    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
//      return page;
//    }));
//  }
//
//  // 自带的不支持路径参数
//  static pushNamed(BuildContext context, String routeName, {Object arguments}) {
//    Navigator.pushNamed(context, routeName, arguments: arguments);
//  }
//
//  static pushWithFadeTransition(BuildContext context, Widget page) {
//    Navigator.of(context).push(PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return page;
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return _transition(animation, child);
//        }));
//  }
//
//  static FadeTransition _transition(Animation<double> animation, Widget child) {
//    return FadeTransition(
//      opacity: animation,
//      child: FadeTransition(
//        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//        child: child,
//      ),
//    );
//  }
}

// Navigator.push 时的 context 参数不能是首屏 Widget 的 context
class AdaptiveWebInitHashWidget extends StatefulWidget {
  @override
  _AdaptiveWebInitHashWidgetState createState() => _AdaptiveWebInitHashWidgetState();
}

class _AdaptiveWebInitHashWidgetState extends State<AdaptiveWebInitHashWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RouteUtil.handleGoInitHashRoute(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
