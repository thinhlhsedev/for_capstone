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

  Component.fromJson(Map<String, dynamic> json) {
    componentId = json['componentId'];
    componentName = json['componentName'];
    amount = json['amount'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    substance = json['substance'];
    size = json['size'];
    color = json['color'];
    weight = json['weight'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['componentId'] = componentId;
    data['componentName'] = componentName;
    data['amount'] = amount;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['substance'] = substance;
    data['size'] = size;
    data['color'] = color;
    data['weight'] = weight;
    data['description'] = description;
    return data;
  }
}