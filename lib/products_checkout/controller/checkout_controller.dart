import 'package:apnidhukan/core/local_db/carts_dao.dart';
import 'package:apnidhukan/payment/presentation/payment_screen.dart';
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
    await Get.to(PaymentScreen());

    removeProductsFromCart();
  }

  Future<void> removeProductsFromCart() async {
    await CartsDao.deleteProducts(cartData);
  }

  void updateQuantity(int id, int? value) {}
}
