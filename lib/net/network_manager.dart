import 'package:dio/dio.dart';

class NetworkManager {
  // 保存单例
  static final NetworkManager _instance = new NetworkManager._();

  // 工厂构造函数
  factory NetworkManager() => _instance;

  // 获取单例
  static NetworkManager get instance => _instance;

  final Dio _dio = Dio();

  Dio get dio => _dio;

  // 私有构造函数
  NetworkManager._() {
    _dio.options.baseUrl = 'https://api.github.com/';
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    // 默认会将请求体转换为 json 对象（Map），不用再手动 json.encode
    _dio.options.contentType = Headers.jsonContentType;
    // 默认会将响应体转换为 json 对象（Map），不用再手动 json.decode
    _dio.options.responseType = ResponseType.json;
    // 添加日志拦截器
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
