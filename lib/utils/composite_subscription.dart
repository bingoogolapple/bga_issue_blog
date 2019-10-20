import 'dart:async';

class CompositeSubscription {
  Set<StreamSubscription> _subscriptionSet = Set<StreamSubscription>();
  bool _unsubscribed = false;

  bool get isUnsubscribed => _unsubscribed;

  void add(final StreamSubscription subscription) {
    if (_unsubscribed) {
      subscription.cancel();
      return;
    }
    _subscriptionSet.add(subscription);
  }

  void remove(final StreamSubscription subscription) {
    if (!hasSubscriptions()) {
      return;
    }

    if (_subscriptionSet.remove(subscription)) {
      subscription.cancel();
    }
  }

  void cancel() {
    _unsubscribed = true;
    if (!hasSubscriptions()) {
      return;
    }

    List exceptionList = [];
    for (StreamSubscription subscription in _subscriptionSet) {
      try {
        subscription.cancel();
      } catch (e) {
        print(e);
      }
    }

    if (exceptionList.isNotEmpty) {
      if (exceptionList.length == 1) {
        throw exceptionList[0];
      } else {
        throw '取消 StreamSubscription 时出现多个异常';
      }
    }
  }

  bool hasSubscriptions() {
    if (_unsubscribed) {
      return false;
    }
    return _subscriptionSet.isNotEmpty;
  }
}
