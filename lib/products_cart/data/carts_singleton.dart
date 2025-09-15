import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:flutter/widgets.dart';

import '../modules/cart_product.dart';

class CartsSingleton {
  static List<CartProduct> cartData = [];

  static bool isPresentInCart(int productId){
    return cartData.any((p) => p.productItem.id == productId);
  }

  static void addToCart({required ProductItem product}) {
    bool isExists = cartData.any((p) => p.productItem.id == product.id);

    if (!isExists) {
      cartData.add(CartProduct(productItem: product));
      debugPrint(
        "CartsSingleton product added to cart, data == ${cartData.first.productItem}",
      );
    }
  }

  static void printData(){
    cartData.forEach((c){
      debugPrint("CartsSingleton cart data ===== id:  ${c.productItem.id}  == title ${c.productItem.title}  ");
    });
  }

  // update quantity by product id
  static void updateQuantity({required int id, required int quantity}) {


    cartData.forEach((c){
      debugPrint("CartsSingleton cart data ===== id:  ${c.productItem.id}  == title ${c.productItem.title}  ");
    });

    final cartProduct = cartData.firstWhere((p) => p.productItem.id == id);

    if (cartProduct.quantity == 0) return;

    cartData.remove(cartProduct);

    if (quantity > 0) {
      cartProduct.updateQuantity(quantity);
      cartData.add(cartProduct);

      debugPrint("success CartsSingleton update productId == $id quantity == $quantity");
    }
  }

  static void removeProduct(int id) {
    cartData.removeWhere((p) => p.productItem.id == id);
  }

  static void clearCart() {
    cartData.clear();
  }
}
