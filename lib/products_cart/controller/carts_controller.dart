import 'package:apnidhukan/core/local_db/carts_dao.dart';
import 'package:apnidhukan/products_cart/data/carts_singleton.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:get/get.dart';

class CartsController extends GetxController {
  RxList<CartProduct> cart = <CartProduct>[].obs;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    cart.addAll(CartsSingleton.cartData);
    updateTotalPrice();
  }

  Future<void> readCartData() async {
    cart.clear();

    // List<CartProduct> data = CartsSingleton.cartData;
    List<CartProduct> data = await CartsDao.getCartProducts();

    data.sort((a, b) => a.productItem.id.compareTo(b.productItem.id));

    cart.addAll(data);
    updateTotalPrice();
  }

  Future<void> removeFromCart(int productId) async {
    // CartsSingleton.removeProduct(productId);
    await CartsDao.deleteProduct(productId);
    await readCartData();
  }

  Future<void> updateQuantity(int productId, int? value) async {
    //    CartsSingleton.updateQuantity(id: productId, quantity: value ?? 1);
    await CartsDao.updateProductQuantity(productId, value ?? 1);
    await readCartData();
  }

  void updateTotalPrice() {
    double sum = 0.0;
    for (var item in cart) {
      sum += item.quantity * item.productItem.price;
    }
    totalPrice.value = sum; // keep the raw value
  }

  void printData() {
    CartsSingleton.printData();
  }
}
