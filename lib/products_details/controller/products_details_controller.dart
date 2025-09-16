import 'package:apnidhukan/core/local_db/carts_dao.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_screen/controller/main_screen_controller.dart';
import '../../products_checkout/presentation/checkout_screen.dart';

class ProductsDetailsController extends GetxController {
  RxBool isFavorite = false.obs;
  RxBool isAddedToCart = false.obs;
  ProductItem product = ProductItem();

  Future<void> setProduct(ProductItem productItem) async {
    product = productItem;

    isAddedToCart.value = await CartsDao.isPresentInCart(product.id);
    // isAddedToCart.value = CartsSingleton.isPresentInCart(product.id);
  }

  Future<void> addToCart() async {
    await CartsDao.insertCartProduct(CartProduct(productItem: product, quantity: 1));
    isAddedToCart.value = true;
  }

  void navigateToCartScreen() {
    final mainScreenController = Get.find<MainScreenController>();

    mainScreenController.navigate(mainScreenController.cartsScreenIdx);

    Get.back();
  }

  void navigateToCheckout(List<CartProduct> cart) {
    Get.to(CheckoutScreen(), arguments: {'data': cart});
  }

  void updateIsFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void updateDeliveryAddress() {
    showBottomSheet();
  }

  void showBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      isDismissible: true,
      Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 12, backgroundColor: Colors.red),

            title: Text("Title"),
            subtitle: Text("Sub Title"),
          ),

          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
