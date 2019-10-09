import 'dart:async';

class CompositeSubscription {
  Set<StreamSubscription> subscriptions = Set<StreamSubscription>();
  bool unsubscribed = false;

  bool isUnsubscribed() {
    return unsubscribed;
  }

  void add(final StreamSubscription subscription) {
    if (unsubscribed) {
      subscription.cancel();
      return;
    }
    subscriptions.add(subscription);
  }

  void remove(final StreamSubscription subscription) {
    if (!hasSubscriptions()) {
      return;
    }

    if (subscriptions.remove(subscription)) {
      subscription.cancel();
    }
  }

  void cancel() {
    unsubscribed = true;
    if (!hasSubscriptions()) {
      return;
    }

    List exceptionList = [];
    for (StreamSubscription subscription in subscriptions) {
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
    if (unsubscribed) {
      return false;
    }
    return subscriptions.isNotEmpty;
  }
}
