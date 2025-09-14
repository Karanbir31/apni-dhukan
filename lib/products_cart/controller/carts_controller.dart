import 'package:get/get.dart';

import '../../products/presentation/controller/products_controller.dart';

class CartsController extends GetxController {
  final List<Product> dummyProducts = [
    Product(
      id: 1,
      title: "Essence Mascara Lash Princess",
      price: 9.99,
      images: [
        "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp",
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
        "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp",
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
        "https://cdn.dummyjson.com/product-images/beauty/powder-canister/1.webp",
      ],
      description:
          "The Powder Canister is a finely milled setting powder designed to set makeup and control shine. With a lightweight and translucent formula, it provides a smooth and matte finish.",
      category: "beauty",
    ),
  ];
  RxList<int> productsQuantity = [1, 1, 1].obs;

  void updateQuantity(int index, int? value) {
    productsQuantity[index] = value ?? 1;
  }
}
