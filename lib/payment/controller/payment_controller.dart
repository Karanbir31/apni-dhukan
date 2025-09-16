import 'dart:async';

import 'package:apnidhukan/main_screen/presentation/main_screen.dart';
import 'package:apnidhukan/products/presentation/products_screen.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:get/get.dart';

import '../../core/local_db/carts_dao.dart';

class PaymentController extends GetxController {
  RxInt countdown = 5.obs;
  Timer? _timer;

  @override
  void onReady() {
    // TODO: implement onReady

    final arguments = Get.arguments;
    final cartData = arguments['data'];

    if (cartData != null) {
      removeProductsFromCart(cartData);
    }

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        _navigateToProducts();
      }
    });
  }

  void _navigateToProducts() {
    Get.offUntil(
      GetPageRoute(page: () => MainScreen()),
      (route) => false, // clear all previous routes
    );
  }

  Future<void> removeProductsFromCart(List<CartProduct> cartData) async {
    await CartsDao.deleteProducts(cartData);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
