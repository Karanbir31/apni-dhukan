import 'dart:async';

import 'package:apnidhukan/core/local_db/orders/orders_dao.dart';
import 'package:apnidhukan/main_screen/presentation/main_screen.dart';
import 'package:apnidhukan/orders_history/modules/order_item.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:get/get.dart';

import '../../core/local_db/carts_dao.dart';

class PaymentController extends GetxController {
  RxInt countdown = 5.obs;
  Timer? _timer;

  @override
  Future<void> onReady() async {
    // TODO: implement onReady

    final arguments = Get.arguments;
    final cartData = arguments['data'];

    if (cartData != null) {
      await updateOrdersHistory(cartData);

      removeProductsFromCart(cartData);
    }

    _startTimer();
  }

  Future<void> updateOrdersHistory(List<CartProduct> cartData) async {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));  // 1 day before
    final threeDaysAgo = today.subtract(const Duration(days: 3)); // 3 days before
    final nextWeek = today.add(const Duration(days: 7)); // 7 days later


    List<OrderItem> orders = cartData
        .map((c) => OrderItem(cartProduct: c, createdAt: threeDaysAgo))
        .toList();

    await OrdersDao.insertOrderMultiple(orders);
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
