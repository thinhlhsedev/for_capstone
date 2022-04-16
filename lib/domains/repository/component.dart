import 'package:json_annotation/json_annotation.dart';

part 'component.g.dart';

@JsonSerializable()
class Component {
  String? componentId;
  String? componentName;
  int? amount;
  String? imageUrl;
  String? status;
  String? substance;
  String? size;
  String? color;
  double? weight;
  String? description;

  Component(
      {this.componentId,
      this.componentName,
      this.amount,
      this.imageUrl,
      this.status,
      this.substance,
      this.size,
      this.color,
      this.weight,
      this.description});

  factory Component.fromJson(Map<String, dynamic> json) => _$ComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}