import 'product.dart';

class Cart {
  Product? product;
  int? numOfItem;

  Cart({this.product, this.numOfItem});  
}

List<Cart> demoCart = [
    
    Cart(product: demoProduct[0], numOfItem: 2),
    Cart(product: demoProduct[1], numOfItem: 3),
    Cart(product: demoProduct[2], numOfItem: 5),
  ];
