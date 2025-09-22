import 'package:apnidhukan/main_screen/controller/main_screen_controller.dart';
import 'package:get/get.dart';

import '../../products/presentation/controller/products_controller.dart';
import '../../products_cart/controller/carts_controller.dart';
import '../../products_wishlist/controller/wishlist_controller.dart';
import '../../profile/controller/profile_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainScreenController(),fenix: true);

    // Preload child controllers since they’re used inside MainScreen tabs
    Get.lazyPut(() => ProductsController(),fenix: true,);
    Get.lazyPut(() => CartsController(),fenix: true);
    Get.lazyPut(() => ProfileController(),fenix: true);
    Get.lazyPut(() => WishlistController(),fenix: true);
  }
}
