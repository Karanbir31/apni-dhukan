import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products_cart/data/carts_singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_screen/controller/main_screen_controller.dart';

class ProductsDetailsController extends GetxController {
  RxBool isFavorite = false.obs;
  RxBool isAddedToCart = false.obs;
  ProductItem product = ProductItem();



  void setProduct(ProductItem productItem) {
    product = productItem;

    isAddedToCart.value = CartsSingleton.isPresentInCart(product.id);
  }

  void addToCart() {
    CartsSingleton.addToCart(product: product);
    isAddedToCart.value = true;
    debugPrint(
      "ProductsDetailsController CartsSingleton product added to cart",
    );
  }

  void navigateToCartScreen() {
    final mainScreenController = Get.find<MainScreenController>();

    mainScreenController.navigate(mainScreenController.cartsScreenIdx);

    Get.back();
  }

  void updateIsFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void updateDeliveryAddress() {
    showBottomSheet();
  }

  // void myModelBottomSheet(BuildContext context){
  //   showModalBottomSheet(context: context, builder: (){
  //
  //   })
  // }

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
