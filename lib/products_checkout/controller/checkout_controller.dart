import 'package:apnidhukan/core/nav_routes/nav_helper.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/local_db/address/address_dao.dart';
import '../../user_address/modules/address_item.dart';
import '../../user_address/presentation/address_bottom_sheets/select_address_bottom_sheet.dart';

class CheckoutController extends GetxController {
  RxList<CartProduct> cartData = <CartProduct>[].obs;
  RxDouble totalPrice = 0.0.obs;

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

  void setCartsProducts(List<CartProduct> cartsProducts) {
    cartData.clear();
    cartData.addAll(cartsProducts);
    updateTotalPrice();
  }

  void updateTotalPrice() {
    double sum = 0.0;
    for (var item in cartData) {
      sum += item.quantity * item.productItem.price;
    }
    totalPrice.value = sum; // keep the raw value
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

  Future<void> payAndCheckOut() async {
    if (!defaultAddress.value.isAddressNull()) {
      NavHelper.toPayments(cartData);
    } else {
      showSnackBar(
        "Deliver Address is required",
        "Please enter a valid address",
      );
    }
  }

  void showSnackBar(String? text, String? message) {
    Get.snackbar(
      text ?? "Categories Sliver bar is in pinned stated",
      message ?? "",
      backgroundColor: Colors.grey,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.down,
      duration: Duration(seconds: 2),
    );
  }

  void updateQuantity(int id, int? value) {}
}
