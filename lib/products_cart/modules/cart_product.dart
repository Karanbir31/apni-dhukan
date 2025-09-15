import 'package:apnidhukan/products/domain/product_item.dart';

class CartProduct {
  int quantity;
  ProductItem productItem;

  CartProduct({this.quantity = 1, required this.productItem});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productItem: ProductItem.fromJson(json['productItem']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'quantity': quantity, 'productItem': productItem.toJson()};
  }

  void updateQuantity(int value) {
    quantity = value;
  }
}
