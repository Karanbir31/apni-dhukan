import 'package:apnidhukan/products_cart/data/carts_singleton.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/cupertino.dart';
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

  void readCartData() {
    cart.clear();

    List<CartProduct> data = CartsSingleton.cartData;

    data.sort((a, b) => a.productItem.id.compareTo(b.productItem.id));

    cart.addAll(data);
    updateTotalPrice();
  }


  void removeFromCart(int productId){
    CartsSingleton.removeProduct(productId);
    readCartData();
  }

  void updateQuantity(int productId, int? value) {
    debugPrint("CartsController CartsSingleton update quantity == $value");
    CartsSingleton.updateQuantity(id: productId, quantity: value ?? 1);
    readCartData();
  }

  void updateTotalPrice() {
    double sum = 0.0;

    for (var item in cart) {
      sum += item.quantity * item.productItem.price;
    }

    // round to 2 decimal places
    totalPrice.value = double.parse(sum.toStringAsFixed(2));
  }

  double getProductPrice(double price, int quantity) {
    double temp = price * quantity;
    return double.parse(temp.toStringAsFixed(2));
  }

  void printData(){
    CartsSingleton.printData();
  }
}
