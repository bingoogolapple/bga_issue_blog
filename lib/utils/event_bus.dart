import 'dart:async';
import 'package:flutter/material.dart';

class CallbackEventBus {
  // 私有构造函数
  CallbackEventBus._();

  // 保存单例
  static CallbackEventBus _instance = new CallbackEventBus._();

  // 获取单例
  static CallbackEventBus get instance => _instance;

  // 工厂构造函数
  factory CallbackEventBus() => _instance;

  // 保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<ValueChanged>>();

  // 添加订阅者
  void on(eventName, ValueChanged valueChanged) {
    if (eventName == null || valueChanged == null) {
      return;
    }
    _emap[eventName] ??= new List<ValueChanged>();
    _emap[eventName].add(valueChanged);
  }

  // 移除订阅者
  void off(eventName, [ValueChanged valueChanged]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) {
      return;
    }
    if (valueChanged == null) {
      _emap[eventName] = null;
    } else {
      list.remove(valueChanged);
    }
  }

  // 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) {
      return;
    }
    int len = list.length - 1;
    // 反向遍历，防止在订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

class StreamEventBus {
  // 保存单例
  static StreamEventBus _instance;

  // 工厂构造函数
  factory StreamEventBus({bool sync = false, StreamController controller}) => _getInstance(sync: sync, controller: controller);

  // 私有构造函数
  StreamEventBus._({bool sync = false, StreamController controller}) {
    if (controller != null) {
      _streamController = controller;
      return;
    }
    _streamController = StreamController.broadcast(sync: sync);
  }

  static StreamEventBus _getInstance({bool sync = false, StreamController controller}) {
    if (_instance == null) {
      _instance = new StreamEventBus._(sync: sync, controller: controller);
    }
    return _instance;
  }

  StreamController _streamController;

  StreamController get streamController => _streamController;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void emit(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
