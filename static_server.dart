import 'dart:io';
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  var staticHandler = shelf_static.createStaticHandler(Platform.script.resolve('build/web').toFilePath(), defaultDocument: 'index.html', listDirectories: true);
  final handler = shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(staticHandler);
  var server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8888);
  print('Server running on http://localhost:${server.port}');
}
