import 'package:apnidhukan/core/local_db/carts_dao.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products_cart/data/carts_singleton.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:apnidhukan/products_checkout/presentation/checkout_screen.dart';
import 'package:apnidhukan/products_details/presentation/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/local_db/address/address_dao.dart';
import '../../user_address/modules/address_item.dart';
import '../../user_address/presentation/address_bottom_sheets/select_address_bottom_sheet.dart';

class CartsController extends GetxController {
  RxList<CartProduct> cart = <CartProduct>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxBool isLoading = false.obs;

  Rx<AddressItem> defaultAddress = AddressItem(
    name: "",
    contact: "",
    shortAddress: "",
    fullAddress: "",
    latLng: LatLng(0.0, 0.0),
  ).obs;

  Future<void> getAddress() async {
    final address = await AddressDao.getDefaultAddress();

    if (address != null) {
      defaultAddress.value = address;
    }
  }

  Future<void> readCartData() async {
    isLoading.value = true;
    cart.clear();

    // List<CartProduct> data = CartsSingleton.cartData;
    List<CartProduct> data = await CartsDao.getCartProducts();

    data.sort((a, b) => a.productItem.id.compareTo(b.productItem.id));

    isLoading.value = false;
    cart.addAll(data);
    updateTotalPrice();
  }

  Future<void> removeFromCart(int productId) async {
    // CartsSingleton.removeProduct(productId);
    await CartsDao.deleteProduct(productId);
    await readCartData();
  }

  Future<void> updateQuantity(int productId, int? value) async {
    //    CartsSingleton.updateQuantity(id: productId, quantity: value ?? 1);
    await CartsDao.updateProductQuantity(productId, value ?? 1);
    await readCartData();
  }

  void updateTotalPrice() {
    double sum = 0.0;
    for (var item in cart) {
      sum += item.quantity * item.productItem.price;
    }
    totalPrice.value = sum; // keep the raw value
  }

  void printData() {
    CartsSingleton.printData();
  }

  void navigateToProductsDetails(ProductItem productItem) {
    Get.to(ProductsDetailsScreen(), arguments: {'data': productItem});
  }

  void navigateToCheckout(List<CartProduct> cart) {
    if (cart.isNotEmpty) {
      Get.to(CheckoutScreen(), arguments: {'data': cart});
    }
  }

  void showAddressBottomSheet() {
    Get.bottomSheet(
      SelectAddressBottomSheet(),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,

      //backgroundColor: theme.colorScheme.surface,
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
    );
  }
}
