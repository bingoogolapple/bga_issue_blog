import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(createToJson: false)
class UserInfo {
  String login;
  int id;
  @JsonKey(name: 'node_id')
  String nodeId;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;
  @JsonKey(name: 'gravatar_id')
  String gravatarId;
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'followers_url')
  String followersUrl;
  @JsonKey(name: 'following_url')
  String followingUrl;
  @JsonKey(name: 'gists_url')
  String gistsUrl;
  @JsonKey(name: 'starred_url')
  String starredUrl;
  @JsonKey(name: 'subscriptions_url')
  String subscriptionsUrl;
  @JsonKey(name: 'organizations_url')
  String organizationsUrl;
  @JsonKey(name: 'repos_url')
  String reposUrl;
  @JsonKey(name: 'events_url')
  String eventsUrl;
  @JsonKey(name: 'received_events_url')
  String receivedEventsUrl;
  String type;
  @JsonKey(name: 'site_admin')
  bool siteAdmin;
  String name;
  String company;
  String blog;
  String location;
  String email;
  bool hireable;
  String bio;
  @JsonKey(name: 'public_repos')
  int publicRepos;
  @JsonKey(name: 'public_gists')
  int publicGists;
  int followers;
  int following;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}

/*
{
    "login": "bingoogolapple",
    "id": 8949716,
    "node_id": "MDQ6VXNlcjg5NDk3MTY=",
    "avatar_url": "https://avatars0.githubusercontent.com/u/8949716?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/bingoogolapple",
    "html_url": "https://github.com/bingoogolapple",
    "followers_url": "https://api.github.com/users/bingoogolapple/followers",
    "following_url": "https://api.github.com/users/bingoogolapple/following{/other_user}",
    "gists_url": "https://api.github.com/users/bingoogolapple/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/bingoogolapple/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/bingoogolapple/subscriptions",
    "organizations_url": "https://api.github.com/users/bingoogolapple/orgs",
    "repos_url": "https://api.github.com/users/bingoogolapple/repos",
    "events_url": "https://api.github.com/users/bingoogolapple/events{/privacy}",
    "received_events_url": "https://api.github.com/users/bingoogolapple/received_events",
    "type": "User",
    "site_admin": false,
    "name": "王浩",
    "company": "@Meituan-Dianping",
    "blog": "http://www.bingoogolapple.cn",
    "location": "Chengdu, China",
    "email": null,
    "hireable": true,
    "bio": "自助者天助之，学习ing",
    "public_repos": 90,
    "public_gists": 6,
    "followers": 3399,
    "following": 277,
    "created_at": "2014-09-28T18:26:08Z",
    "updated_at": "2019-10-05T05:54:30Z"
}
 */
