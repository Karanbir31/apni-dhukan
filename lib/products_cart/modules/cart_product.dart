import 'dart:convert';
import 'package:apnidhukan/core/local_db/carts_table.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import '../../core/local_db/db_provider.dart';

class CartProduct {
  int quantity;
  ProductItem productItem;

  CartProduct({this.quantity = 1, required this.productItem});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      // pass whole json so productItem map it's properties and leave quantity
      productItem: ProductItem.fromJson(json),
      quantity: json[CartsTable.columnQuantity] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CartsTable.columnProductId: productItem.id,
      CartsTable.columnTitle: productItem.title,
      CartsTable.columnDescription: productItem.description,
      CartsTable.columnCategory: productItem.category,
      CartsTable.columnPrice: productItem.price,
      CartsTable.columnDiscountPercentage: productItem.discountPercentage,
      CartsTable.columnRating: productItem.rating,
      CartsTable.columnImages: jsonEncode(productItem.images),
      CartsTable.columnBrand: productItem.brand,
      CartsTable.columnQuantity: quantity,
    };
  }

  void updateQuantity(int value) {
    quantity = value;
  }
}
