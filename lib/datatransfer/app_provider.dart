import 'package:bga_issue_blog/datatransfer/app_model.dart';
import 'package:flutter/material.dart';

class AppProvider extends InheritedWidget {
  static AppProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(AppProvider) as AppProvider;

  final AppModel model;

  AppProvider({
    Key key,
    @required this.model,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppProvider oldWidget) =>
      model.userInfo != oldWidget.model.userInfo && model.isAboutMeChecked != oldWidget.model.isAboutMeChecked;
}
