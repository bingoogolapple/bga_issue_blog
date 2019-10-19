import 'package:bga_issue_blog/dto/user_info.dart';
import 'package:flutter/material.dart';

class PageModel with ChangeNotifier {
  int _page = 1;

  int get page => _page;

  set page(page) {
    _page = page;
    notifyListeners();
  }
}

class KeywordModel with ChangeNotifier {
  String _keyword = '';

  String get keyword => _keyword;

  set keyword(keyword) {
    _keyword = keyword;
    notifyListeners();
  }
}

class UserInfoModel with ChangeNotifier {
  UserInfo _userInfo;

  UserInfo get userInfo => _userInfo;

  set userInfo(userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }
}

class CheckedMenuModel with ChangeNotifier {
  bool _isAboutMeChecked = false;

  bool get isAboutMeChecked => _isAboutMeChecked;

  set isAboutMeChecked(isAboutMeChecked) {
    _isAboutMeChecked = isAboutMeChecked;
    notifyListeners();
  }
}

class CurrentLabelModel with ChangeNotifier {
  String _currentLabel;

  String get currentLabel => _currentLabel;

  set currentLabel(currentLabel) {
    _currentLabel = currentLabel;
    notifyListeners();
  }
}

class LabelListModel with ChangeNotifier {
  List _labelList;

  List get labelList => _labelList;

  set labelList(labelList) {
    _labelList = labelList;
    notifyListeners();
  }
}

class IssueListModel with ChangeNotifier {
  List _issueList;

  List get issueList => _issueList;

  set issueList(issueList) {
    _issueList = issueList;
    notifyListeners();
  }

  void addMoreIssueList(List issueList) {
    if (_issueList == null) {
      _issueList = issueList;
    } else {
      _issueList.addAll(issueList);
    }
    notifyListeners();
  }
}
