import 'package:dio/dio.dart';
import 'package:bga_issue_blog/net/network_manager.dart';
import 'package:bga_issue_blog/constants.dart';

abstract class GitHubApi {
  // 获取个人信息 https://api.github.com/users/bingoogolapple
  static Future<dynamic> getGitHubUser() async {
    return NetworkManager.instance.dio.get('users/${Constants.gitHubUsername}').then((Response response) => response.data);
  }

  // 获取标签列表 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/labels
  static Future<dynamic> getLabelList() async {
    return NetworkManager.instance.dio.get('repos/${Constants.repo}/labels').then((Response response) => response.data);
  }

  static Future<dynamic> getUserInfo() async {
    return await Future.wait([getGitHubUser(), getLabelList()]);
  }

  // 分页获取 issue 列表 https://api.github.com/search/issues?q=+state:open+repo:bingoogolapple/bingoogolapple.github.io+label:%22Android%22&sort=created&order=desc&page=1&per_page=20
  static Future<dynamic> getIssueList(String label, String keyword, int currentPage, int pageSize) async {
    String labelStr = '';
    if (label != null && label.trim().length > 0) {
      labelStr = '+label:"$label"';
    }
    return NetworkManager.instance.dio
        .get('search/issues?q=$keyword+state:open+repo:${Constants.repo}$labelStr&sort=created&order=desc&page=$currentPage&per_page=$pageSize')
        .then((Response response) => response.data['items']);
  }

  // 获取 issue 详情 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/issues/209
  static Future<dynamic> getIssue(int number) async {
    return NetworkManager.instance.dio.get('repos/${Constants.repo}/issues/$number').then((Response response) => response.data);
  }

  // 获取指定 issue 的 comment 列表 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/issues/209/comments
  static Future<dynamic> getComments(String url) {
    return NetworkManager.instance.dio.get(url).then((Response response) {
      print(response.data);
      return response.data;
    });
  }
}
