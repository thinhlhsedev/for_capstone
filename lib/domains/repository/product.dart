class Product {
  String? productId;
  String? productName;
  int? amount;
  double? price;
  String? imageUrl;
  String? status;
  String? description;

  Product(
      {this.productId,
      this.productName,
      this.amount,
      this.price,
      this.imageUrl,
      this.status,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    amount = json['amount'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['amount'] = amount;
    data['price'] = price;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['description'] = description;
    return data;
  } 
}

List<Product> demoProduct = [
    Product(
      productId: "df",
      productName: "Head phone 1",
      price: 34
    ),
    Product(
      productId: "fgfg",
      productName: "Head phone 2",
      price: 56
    ),
    Product(
      productId: "dfgas",
      productName: "Head phone 3",
      price: 32
    ),
    Product(
      productId: "ererer",
      productName: "Head phone 1",
      price: 34
    ),
    Product(
      productId: "d2e2f",
      productName: "Head phone 1",
      price: 34
    ),
    Product(
      productId: "d645ff",
      productName: "Head phone 1",
      price: 34
    ),
    Product(
      productId: "567y",
      productName: "Head phone 1",
      price: 34
    ),
    Product(
      productId: "hth",
      productName: "Head phone 1",
      price: 34
    ),
  ];