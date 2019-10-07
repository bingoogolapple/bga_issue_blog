import 'package:json_annotation/json_annotation.dart';

part 'label.g.dart';

@JsonSerializable(createToJson: false)
class Label {
  int id;
  String nodeId;
  String url;
  String name;
  String color;

  @JsonKey(name: 'default')
  bool dft;

  Label();

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
  
  static List<Label> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Label.fromJson(json)).toList();
  }
}