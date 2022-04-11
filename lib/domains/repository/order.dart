class Order {
  int? orderId;
  int? accountId;
  double? totalPrice;
  String? expiryDate;
  String? status;
  String? note;
  bool? isShorTerm;

  Order(
      {this.orderId,
      this.accountId,
      this.totalPrice,
      this.expiryDate,
      this.status,
      this.note,
      this.isShorTerm});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    accountId = json['accountId'];
    totalPrice = json['totalPrice'];
    expiryDate = json['expiryDate'];
    status = json['status'];
    note = json['note'];
    isShorTerm = json['isShorTerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['accountId'] = accountId;
    data['totalPrice'] = totalPrice;
    data['expiryDate'] = expiryDate;
    data['status'] = status;
    data['note'] = note;
    data['isShorTerm'] = isShorTerm;
    return data;
  }
}
