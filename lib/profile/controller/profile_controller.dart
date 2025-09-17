import 'package:apnidhukan/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../orders_history/presentation/order_history_screen.dart';

class ProfileController extends GetxController {
  List<ProfileOtherDetails> profileOtherDetails = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    profileOtherDetails = [
      ProfileOtherDetails(
        text: "Address",
        iconData: Icons.home,
        onClickItem: navigateToAddress,
      ),
      ProfileOtherDetails(
        text: "Wallet",
        iconData: Icons.wallet,
        onClickItem: navigateToWallet,
      ),
      ProfileOtherDetails(
        text: "Cart",
        iconData: Icons.shopping_cart,
        onClickItem: navigateToCart,
      ),
      ProfileOtherDetails(
        text: "Orders",
        iconData: Icons.home,
        onClickItem: navigateToOrders,
      ),
      ProfileOtherDetails(
        text: "Help Center",
        iconData: Icons.headset_mic_rounded,
        onClickItem: navigateToHelpCenter,
      ),
    ];
  }

  void navigateToAddress() {}

  void navigateToWallet() {}

  void navigateToCart() {
    Get.find<MainScreenController>().navigate(1);
  }

  void navigateToOrders() {
    Get.to(OrderHistoryScreen());
  }

  void navigateToHelpCenter() {}
}

class ProfileOtherDetails {
  String text;
  IconData iconData;
  void Function() onClickItem;

  ProfileOtherDetails({
    required this.text,
    required this.iconData,
    required this.onClickItem,
  });
}
