import 'dart:convert';

import 'package:apnidhukan/products_cart/modules/cart_product.dart';

import '../../core/local_db/orders/orders_table.dart';

class OrderItem {
  int? id; // primary key
  CartProduct cartProduct;
  DateTime createdAt;

  OrderItem({this.id, required this.cartProduct, required this.createdAt});

  Map<String, dynamic> toJson() {
    var productItem = cartProduct.productItem;

    return {
      OrdersTable.columnProductId: productItem.id,
      OrdersTable.columnTitle: productItem.title,
      OrdersTable.columnDescription: productItem.description,
      OrdersTable.columnCategory: productItem.category,
      OrdersTable.columnPrice: productItem.price,
      OrdersTable.columnDiscountPercentage: productItem.discountPercentage,
      OrdersTable.columnRating: productItem.rating,
      OrdersTable.columnImages: jsonEncode(productItem.images),
      OrdersTable.columnBrand: productItem.brand,
      OrdersTable.columnQuantity: cartProduct.quantity,

      OrdersTable.columnCreatedAt: createdAt.toIso8601String(), // store as text
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      cartProduct: CartProduct.fromJson(json),
      createdAt: DateTime.parse(json[OrdersTable.columnCreatedAt]),
    );
  }
}
