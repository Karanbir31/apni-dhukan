import 'package:apnidhukan/main_screen/controller/main_screen_controller.dart';
import 'package:get/get.dart';

import '../../products/domain/product_item.dart';
import '../../products_cart/modules/cart_product.dart';
import 'nav_routes.dart';

class NavHelper {
  static void toProducts() {
    Get.toNamed(NavRoutes.mainScreenRoute, preventDuplicates: true);
    final mainScreenController = Get.find<MainScreenController>();

    mainScreenController.navigate(mainScreenController.productsScreenInx);
  }

  // what is issue here i will navigate to us to products screen
  // which is 0th index screen in bottom nav of main screen
  static void toCart() {
    Get.toNamed(NavRoutes.mainScreenRoute, preventDuplicates: true);
    final mainScreenController = Get.find<MainScreenController>();
    // mainScreenController.bottomNavSelectedIdx.value = 1;
    // mainScreenController.bottomNavSelectedIdx.refresh();
    mainScreenController.navigate(mainScreenController.cartsScreenIdx);
  }

  static void toProfile() {
    Get.toNamed(NavRoutes.mainScreenRoute, preventDuplicates: true);

    final mainScreenController = Get.find<MainScreenController>();

    mainScreenController.navigate(mainScreenController.profileScreenIdx);
  }

  static void toWishlist() {
    Get.toNamed(NavRoutes.mainScreenRoute, preventDuplicates: true);

    final mainScreenController = Get.find<MainScreenController>();

    mainScreenController.navigate(mainScreenController.wishListScreenIdx);
  }

  static void toProductDetails(ProductItem productItem) => Get.toNamed(
    NavRoutes.productDetailsRoute,
    arguments: {'data': productItem},
  );

  static void toOrdersHistory() => Get.toNamed(NavRoutes.ordersHistoryRoute);

  static void toCheckout(List<CartProduct> cart) {
    Get.toNamed(NavRoutes.checkoutRoute, arguments: {'data': cart});
  }

  static void toPayments(List<CartProduct> cart) =>
      Get.toNamed(NavRoutes.paymentsRoute, arguments: {'data': cart});

  // /// Authentication is optional (depends on your flow)
  // static void toAuthentication() =>
  //     Get.offAllNamed(NavRoutes.authenticationRoute);

  /// Helpers for going back
  static void back() => Get.back();

  static void offAllToProducts() {
    Get.offAllNamed(NavRoutes.mainScreenRoute);

    Get.find<MainScreenController>().navigate(1);
  }

  static void toAddress() {
    Get.toNamed(NavRoutes.addressRoute);
  }
}
