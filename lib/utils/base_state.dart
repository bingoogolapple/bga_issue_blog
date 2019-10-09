import 'dart:async';
import 'package:bga_issue_blog/utils/composite_subscription.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final CompositeSubscription _compositeSubscription = CompositeSubscription();

  void addSubscription(StreamSubscription subscription) {
    _compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    _compositeSubscription.cancel();
    super.dispose();
  }
}
