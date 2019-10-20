import 'package:flutter/foundation.dart';

class CompositeChangeNotifier {
  Set<ChangeNotifier> _changeNotifierSet = Set<ChangeNotifier>();

  T addAndGetChangeNotifier<T extends ChangeNotifier>(T changeNotifier) {
    _changeNotifierSet.add(changeNotifier);
    return changeNotifier;
  }

  void dispose() {
    if (_changeNotifierSet.isEmpty) {
      return;
    }

    List exceptionList = [];
    for (ChangeNotifier changeNotifier in _changeNotifierSet) {
      try {
        changeNotifier.dispose();
      } catch (e) {
        print(e);
      }
    }

    if (exceptionList.isNotEmpty) {
      if (exceptionList.length == 1) {
        throw exceptionList[0];
      } else {
        throw '取消 ChangeNotifier 时出现多个异常';
      }
    }
  }
}
