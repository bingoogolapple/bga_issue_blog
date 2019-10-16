import 'package:bga_issue_blog/datatransfer/app_model.dart';
import 'package:flutter/material.dart';

class AppModelChangedNotification extends Notification {

  AppModelChangedNotification(this.appModel);

  final AppModel appModel;
}