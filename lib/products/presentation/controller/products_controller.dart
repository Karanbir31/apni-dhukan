import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  RxBool isCategoriesAppBarCollapsed = false.obs;
  RxInt topSliverBarSelectedIdx = 1.obs;


  List<Map<Icon, String>> categories = [
    {Icon(Icons.access_alarm): "Clock"},
    {Icon(Icons.phone_android): "Mobile"},
    {Icon(Icons.laptop): "Laptop"},
    {Icon(Icons.chair): "Furniture"},
    {Icon(Icons.watch): "Watch"},
    {Icon(Icons.book): "Books"},
    {Icon(Icons.headphones): "Headphones"},
  ];

  void showSnackBar() {
    Get.snackbar(
      "Categories Sliver bar is in pinned stated",
      "",
      backgroundColor: Colors.grey,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.down,
      duration: Duration(seconds: 2),
    );
  }

  void updateCategoriesAppBarState({required bool value}){
    isCategoriesAppBarCollapsed.value = value;
  }
  void updateTopSliverBarSelectedIdx({required int idx}){
    topSliverBarSelectedIdx.value = idx;
  }


  final List<Product> dummyProducts = [
    Product(
      id: 1,
      title: "Essence Mascara Lash Princess",
      price: 9.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp"
      ],
      description:
      "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
      category: "beauty",
    ),
    Product(
      id: 2,
      title: "Eyeshadow Palette with Mirror",
      price: 19.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp"
      ],
      description:
      "The Eyeshadow Palette with Mirror offers a versatile range of eyeshadow shades for creating stunning eye looks. With a built-in mirror, it's convenient for on-the-go makeup application.",
      category: "beauty",
    ),
    Product(
      id: 3,
      title: "Powder Canister",
      price: 14.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/powder-canister/1.webp"
      ],
      description:
      "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
      category: "beauty",
    ),
    Product(
      id: 4,
      title: "Red Lipstick",
      price: 12.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp"
      ],
      description:
      "The Red Lipstick is a classic and bold choice for adding a pop of color to your lips. With a creamy and pigmented formula, it provides a vibrant and long-lasting finish.",
      category: "beauty",
    ),
    Product(
      id: 5,
      title: "Red Nail Polish",
      price: 8.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/1.webp"
      ],
      description:
      "The Red Nail Polish offers a rich and glossy red hue for vibrant and polished nails. With a quick-drying formula, it provides a salon-quality finish at home.",
      category: "beauty",
    ),
    Product(
      id: 6,
      title: "Calvin Klein CK One",
      price: 49.99,
      images: [
        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/2.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/3.webp",
      ],
      description:
      "CK One by Calvin Klein is a classic unisex fragrance, known for its fresh and clean scent. It's a versatile fragrance suitable for everyday wear.",
      category: "fragrances",
    ),
    Product(
      id: 7,
      title: "Chanel Coco Noir Eau De",
      price: 129.99,
      images: [
        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/1.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/2.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/3.webp",
      ],
      description:
      "Coco Noir by Chanel is an elegant and mysterious fragrance, featuring notes of grapefruit, rose, and sandalwood. Perfect for evening occasions.",
      category: "fragrances",
    ),
    Product(
      id: 8,
      title: "Dior J'adore",
      price: 89.99,
      images: [
        "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/1.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/2.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/dior-j'adore/3.webp",
      ],
      description:
      "J'adore by Dior is a luxurious and floral fragrance, known for its blend of ylang-ylang, rose, and jasmine. It embodies femininity and sophistication.",
      category: "fragrances",
    ),
    Product(
      id: 9,
      title: "Dolce Shine Eau de",
      price: 69.99,
      images: [
        "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/1.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/2.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/3.webp",
      ],
      description:
      "Dolce Shine by Dolce & Gabbana is a vibrant and fruity fragrance, featuring notes of mango, jasmine, and blonde woods. It's a joyful and youthful scent.",
      category: "fragrances",
    ),
    Product(
      id: 10,
      title: "Gucci Bloom Eau de",
      price: 79.99,
      images: [
        "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/1.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/2.webp",
        "https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/3.webp",
      ],
      description:
      "Gucci Bloom by Gucci is a floral and captivating fragrance, with notes of tuberose, jasmine, and Rangoon creeper. It's a modern and romantic scent.",
      category: "fragrances",
    ),
  ];



}

// product_model.dart
class Product {
  final int id;
  final String title;
  final double price;
  final List<String> images;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.description,
    required this.category,
  });

  // Factory method for parsing JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images']),
      description: json['description'],
      category: json['category'],
    );
  }

  // Convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'images': images,
      'description': description,
      'category': category,
    };
  }
}
