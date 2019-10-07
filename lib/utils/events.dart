import 'package:bga_issue_blog/utils/event_bus.dart';

// 定义一个 top-level 变量，页面引入该文件后可以直接使用 bus
var callbackBus = new CallbackEventBus();
const event_label_changed = "event_label_changed";

var streamBus = new StreamEventBus();

class LabelChangedEvent {
  String label;

  LabelChangedEvent(this.label);
}
