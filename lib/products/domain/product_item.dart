import 'dart:convert';

import '../../core/local_db/carts_table.dart';

class ProductItem {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  List<String> images;
  String brand;

  ProductItem({
    this.id = 0,
    this.title = "title",
    this.description = "description",
    this.category = "category",
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.images = const [],
    this.brand = "brand name",
  });

  Map<String, dynamic> toJson() {
    return {
      CartsTable.columnProductId: id,
      CartsTable.columnTitle: title,
      CartsTable.columnDescription: description,
      CartsTable.columnCategory: category,
      CartsTable.columnPrice: price,
      CartsTable.columnDiscountPercentage: discountPercentage,
      CartsTable.columnRating: rating,
      CartsTable.columnImages: jsonEncode(images),
      CartsTable.columnBrand: brand,
    };
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json[CartsTable.columnProductId] ?? 0,
      title: json[CartsTable.columnTitle] ?? '',
      description: json[CartsTable.columnDescription] ?? '',
      category: json[CartsTable.columnCategory] ?? '',
      price: (json[CartsTable.columnPrice] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json[CartsTable.columnDiscountPercentage] as num?)?.toDouble() ??
          0.0,
      rating: (json[CartsTable.columnRating] as num?)?.toDouble() ?? 0.0,
      brand: json[CartsTable.columnBrand] ?? '',

      /// 🔑 FIX: Support both String (from DB) and List (from API)
      images: () {
        final raw = json[CartsTable.columnImages];
        if (raw == null) return <String>[];
        if (raw is String) {
          try {
            return List<String>.from(jsonDecode(raw));
          } catch (_) {
            return <String>[]; // fallback if malformed
          }
        }
        if (raw is List) {
          return List<String>.from(raw.map((e) => e.toString()));
        }
        return <String>[];
      }(),

    );
  }
}
