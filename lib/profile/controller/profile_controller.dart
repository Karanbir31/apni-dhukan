import 'package:apnidhukan/core/nav_routes/nav_helper.dart';
import 'package:apnidhukan/user_address/presentation/address_bottom_sheets/select_address_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  List<ProfileOtherDetails> profileOtherDetails = [];

  @override
  void onInit() {
    super.onInit();

    profileOtherDetails = [
      ProfileOtherDetails(
        text: "Address",
        iconData: Icons.location_on_outlined,
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

  void navigateToAddress() {
    // NavHelper.toAddress();
    showFilterBottomSheet();
  }

  void showFilterBottomSheet() {
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

  void navigateToWallet() {}

  void navigateToCart() {
    NavHelper.toCart();
  }

  void navigateToOrders() {
    NavHelper.toOrdersHistory();
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
