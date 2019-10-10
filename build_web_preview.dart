import 'dart:io';
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  print('构建 web 产物...');
  await Process.run('flutter', ['clean']);
  await Process.run('flutter', ['build', 'web']);

  print('拷贝到 web 构建产物到 docs 目录..');
  final docs = Directory('docs');
  if (docs.existsSync()) {
    docs.deleteSync(recursive: true);
  }
  Directory('build/web').renameSync('docs');

  print('创建 GitHub Pages CNAME');
  File('docs/CNAME').writeAsStringSync('issues.bingoogolapple.cn');

  print('启动静态服务..');
  await startStaticServer();
  print('打开浏览器进行预览..');
  await Process.run('open', ['http://localhost:8888']);
}

startStaticServer() async {
  var staticHandler = shelf_static.createStaticHandler(Platform.script.resolve('docs').toFilePath(), defaultDocument: 'index.html', listDirectories: true);
  final handler = shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(staticHandler);
  var server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8888);
  print('Server running on http://localhost:${server.port}');
}
