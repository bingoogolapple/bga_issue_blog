import 'dart:io';
import 'package:http_server/http_server.dart';

void main() {
  var virDir;
  virDir = new VirtualDirectory(Platform.script.resolve('build/web').toFilePath())
    ..allowDirectoryListing = true // 是否获取文件和目录清单，为 false 则不获取
    ..errorPageHandler = (HttpRequest request) {
      // 覆盖默认的错误处理页面，要注意顺序（错误处理要放在正常处理前面，否则无效）
      request.response
        ..statusCode = HttpStatus.notFound // 设置状态码，如果没有设置则默认 HttpStatus.OK
        ..write('Not found')
        ..close();
    }
    ..directoryHandler = (dir, request) {
      if (request.uri.path == '/') {
        // 用指定的文件覆盖默认返回的目录清单
        var indexUri = new Uri.file(dir.path).resolve('index.html'); // 获取文件的路径
        virDir.serveFile(new File(indexUri.toFilePath()), request); // 返回指定的文件
      }
    };

  HttpServer.bind(InternetAddress.loopbackIPv4, 8888).then((server) {
    server.listen((request) {
      // 将文件和目录清单发送到客户端
      virDir.serveRequest(request);
    });
  });
}
