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
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'images': images,
      'brand': brand,
    };
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: ((json['price'] as num?)?.toDouble() ?? 0.0) * 90
        ..toStringAsFixed(2),
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      brand: json['brand'] ?? '',
    );
  }
}
