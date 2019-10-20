import 'package:bga_issue_blog/dto/label.dart';
import 'package:bga_issue_blog/dto/user_info.dart';
import 'package:dio/dio.dart';
import 'package:bga_issue_blog/net/network_manager.dart';
import 'package:bga_issue_blog/utils/config.dart';

abstract class GitHubApi {
  // 获取个人信息 https://api.github.com/users/bingoogolapple
  static Future<UserInfo> getUserInfo() {
    return NetworkManager.instance.dio.get('users/${Config.gitHubUsername}').then((Response response) => UserInfo.fromJson(response.data));
  }

  // 获取标签列表 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/labels
  static Future<List<Label>> getLabelList() {
    return NetworkManager.instance.dio.get('repos/${Config.repo}/labels').then((Response response) => Label.fromJsonList(response.data));
  }

  // 分页获取 issue 列表 https://api.github.com/search/issues?q=+state:open+repo:bingoogolapple/bingoogolapple.github.io+label:%22Android%22&sort=created&order=desc&page=1&per_page=20
  static Future<dynamic> getIssueList(String label, String keyword, int currentPage, int pageSize) {
    String labelStr = '';
    if (label != null && label.trim().length > 0) {
      labelStr = '+label:"$label"';
    }
    return NetworkManager.instance.dio
        .get('search/issues?q=$keyword+state:open+repo:${Config.repo}$labelStr&sort=created&order=desc&page=$currentPage&per_page=$pageSize')
        .then((Response response) => response.data['items']);
  }

  // 获取 issue 详情 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/issues/209
  static Future<dynamic> getIssue(int number) {
    return NetworkManager.instance.dio.get('repos/${Config.repo}/issues/$number').then((Response response) => response.data);
  }

  // 获取指定 issue 的 comment 列表 https://api.github.com/repos/bingoogolapple/bingoogolapple.github.io/issues/209/comments
  static Future<dynamic> getComments(String url) {
    return NetworkManager.instance.dio.get(url).then((Response response) {
      return response.data;
    });
  }

  // 获取关于我信息 https://raw.githubusercontent.com/bingoogolapple/bingoogolapple.github.io/master/README.md
  static Future<dynamic> getReadme() {
    return NetworkManager.instance.dio.get('https://raw.githubusercontent.com/${Config.repo}/master/README.md').then((Response response) => response.data);
  }
}
