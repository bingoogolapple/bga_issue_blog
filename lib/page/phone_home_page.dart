import 'package:bga_issue_blog/datatransfer/data_model.dart';
import 'package:bga_issue_blog/utils/base_state.dart';
import 'package:bga_issue_blog/widget/about_me_widget.dart';
import 'package:bga_issue_blog/widget/issue_list.dart';
import 'package:bga_issue_blog/widget/label_list.dart';
import 'package:bga_issue_blog/datatransfer/events.dart';
import 'package:bga_issue_blog/widget/left_widget.dart';
import 'package:bga_issue_blog/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class PhoneHomePage extends StatefulWidget {
  @override
  _PhoneHomePageState createState() => _PhoneHomePageState();
}

class _PhoneHomePageState extends BaseState<PhoneHomePage> with SingleTickerProviderStateMixin {
  final GlobalKey _phoneHomeStackKey = GlobalKey(debugLabel: 'PhoneHomeStackKey');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
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

  double get _phoneHomeStackHeight {
    final RenderBox renderBox = _phoneHomeStackKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) {
      return;
    }

    _controller.value += details.primaryDelta / (_phoneHomeStackHeight * 2 / 3);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating) {
      return;
    }

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _phoneHomeStackHeight;
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
        title: _buildTitle(),
        actions: _buildActions(),
      ),
      drawer: Drawer(child: LeftWidget()),
      body: Consumer<CheckedMenuModel>(builder: (context, checkedMenuModel, _) {
        if (checkedMenuModel.isAboutMeChecked) {
          return AboutMePage();
        }
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(key: _phoneHomeStackKey, children: [
              _buildBottomPanelWidget(context),
              _buildTopPanelWidget(context, constraints),
            ]);
          },
        );
      }),
    );
  }

  List<Widget> _buildActions() {
    return [
      Consumer<CheckedMenuModel>(builder: (context, checkedMenuModel, _) {
        if (checkedMenuModel.isAboutMeChecked) {
          return SizedBox();
        }
        return IconButton(
          onPressed: _toggleBottomPanelVisibility,
          icon: AnimatedIcon(icon: AnimatedIcons.ellipsis_search, semanticLabel: 'search', progress: ReverseAnimation(_controller.view)),
        );
      })
    ];
  }

  Widget _buildTitle() {
    return Consumer<CheckedMenuModel>(builder: (context, checkedMenuModel, _) {
      if (checkedMenuModel.isAboutMeChecked) {
        return Text('关于我');
      }
      return BackdropTitle(listenable: _controller.view);
    });
  }

  Widget _buildBottomPanelWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: SearchWidget(),
            ),
            LabelList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPanelWidget(BuildContext context, BoxConstraints constraints) {
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
        end: RelativeRect.fromLTRB(0, constraints.biggest.height * 0.5, 0, 0),
      ).animate(_controller),
      child: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(32),
          topRight: const Radius.circular(32),
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
                    child: Consumer<CurrentLabelModel>(
                      builder: (context, currentLabelModel, _) {
                        return Text(currentLabelModel.currentLabel ?? '全部博客');
                      },
                    ),
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
          // animation 的值为 0.5 ~ 1.0 时显示，Reverse 后就是 0.0 ~ 0.5
          opacity: CurvedAnimation(parent: ReverseAnimation(animation), curve: const Interval(0.5, 1.0)).value,
          child: const Text('博客列表'),
        ),
      ]),
    );
  }
}
