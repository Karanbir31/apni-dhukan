import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:get/get.dart';

class CartsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartsController());
  }
}
