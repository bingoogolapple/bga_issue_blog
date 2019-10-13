import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/widget/issue_list.dart';
import 'package:bga_issue_blog/widget/label_list.dart';
import 'package:bga_issue_blog/utils/events.dart';
import 'package:bga_issue_blog/widget/search_layout.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PhoneHomePage extends StatefulWidget {
  @override
  _PhoneHomePageState createState() => _PhoneHomePageState();
}

class _PhoneHomePageState extends BaseState<PhoneHomePage> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  String _currentLabel;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _currentLabel = event.label;
      _controller.fling(velocity: -2);
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _bottomPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBottomPanelVisibility() {
    // 小于 0 关闭，大于 0 打开
    _controller.fling(velocity: _bottomPanelVisible ? -2 : 2);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) {
      return;
    }

    _controller.value += details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating) {
      return;
    }

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0) {
      _controller.fling(velocity: math.min(-2, flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: math.max(2, flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2 : 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: BackdropTitle(
          listenable: _controller.view,
        ),
        actions: [
          IconButton(
            onPressed: _toggleBottomPanelVisibility,
            icon: AnimatedIcon(icon: AnimatedIcons.close_menu, semanticLabel: 'close', progress: ReverseAnimation(_controller.view)),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(key: _backdropKey, children: [
            buildBottomPanelWidget(context),
            buildTopPanelWidget(context, constraints),
          ]);
        },
      ),
    );
  }

  Widget buildBottomPanelWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: Column(
          children: <Widget>[
            SearchLayout(),
            LabelList(),
          ],
        ),
      ),
    );
  }

  Widget buildTopPanelWidget(BuildContext context, BoxConstraints constraints) {
    final Size panelSize = constraints.biggest;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
        end: RelativeRect.fromLTRB(0, panelSize.height * 0.3, 0, 0),
      ).animate(_controller),
      child: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              onTap: _toggleBottomPanelVisibility,
              child: Container(
                height: 48.0,
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                alignment: AlignmentDirectional.centerStart,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.subhead,
                  child: Tooltip(
                    message: _bottomPanelVisible ? '点击关闭过滤面板' : '点击打开过滤面板',
                    child: Text(_currentLabel == null ? '全部博客' : _currentLabel),
                  ),
                ),
              ),
            ),
            Divider(thickness: 2, indent: 15, endIndent: 15),
            Expanded(child: IssueList()),
          ],
        ),
      ),
    );
  }
}

class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({Key key, Listenable listenable}) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    // DefaultTextStyle：设置内部 Text 的公共样式
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Stack(children: [
        Opacity(
          // animation 的值为 0.5 ~ 1.0 时显示
          opacity: CurvedAnimation(parent: animation, curve: const Interval(0.5, 1.0)).value,
          child: const Text('修改过滤条件'),
        ),
        Opacity(
          // animation 的值为 0.0 ~ 0.5 时显示，Reverse 后就是 0.5 ~ 1.0
          opacity: CurvedAnimation(parent: ReverseAnimation(animation), curve: const Interval(0.5, 1.0)).value,
          child: const Text('博客列表'),
        ),
      ]),
    );
  }
}
