import 'dart:async';
import 'package:bga_issue_blog/utils/composite_change_notifier.dart';
import 'package:bga_issue_blog/utils/composite_subscription.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final CompositeSubscription _compositeSubscription = CompositeSubscription();
  final CompositeChangeNotifier _compositeChangeNotifier = CompositeChangeNotifier();

  void addSubscription(StreamSubscription subscription) {
    _compositeSubscription.add(subscription);
  }

  T addAndGetChangeNotifier<T extends ChangeNotifier>(T changeNotifier) {
    return _compositeChangeNotifier.addAndGetChangeNotifier(changeNotifier);
  }

  @override
  void dispose() {
    _compositeSubscription.cancel();
    _compositeChangeNotifier.dispose();
    super.dispose();
  }
}
