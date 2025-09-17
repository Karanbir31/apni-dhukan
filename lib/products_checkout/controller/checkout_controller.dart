import 'package:apnidhukan/core/nav_routes/nav_helper.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  RxList<CartProduct> cartData = <CartProduct>[].obs;
  RxDouble totalPrice = 0.0.obs;

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

  void changeDeliveryAddress() {}

  Future<void> payAndCheckOut() async {
    NavHelper.toPayments(cartData);
  }

  void updateQuantity(int id, int? value) {}
}
