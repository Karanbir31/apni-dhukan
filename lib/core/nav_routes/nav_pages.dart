import 'package:apnidhukan/core/nav_routes/nav_routes.dart';
import 'package:apnidhukan/main_screen/controller/main_screen_binding.dart';
import 'package:apnidhukan/main_screen/presentation/main_screen.dart';
import 'package:apnidhukan/payment/controller/payment_bindings.dart';
import 'package:apnidhukan/payment/presentation/payment_screen.dart';
import 'package:apnidhukan/products/presentation/controller/products_binding.dart';
import 'package:apnidhukan/products/presentation/products_screen.dart';
import 'package:apnidhukan/products_cart/controller/carts_binding.dart';
import 'package:apnidhukan/products_cart/presentation/carts_screen.dart';
import 'package:apnidhukan/products_checkout/controller/checkout_binding.dart';
import 'package:apnidhukan/products_checkout/presentation/checkout_screen.dart';
import 'package:apnidhukan/products_details/controller/products_details_binding.dart';
import 'package:apnidhukan/products_details/presentation/products_details_screen.dart';
import 'package:apnidhukan/products_wishlist/controller/wishlist_binding.dart';
import 'package:apnidhukan/products_wishlist/presentatation/wishlist_screen.dart';
import 'package:apnidhukan/profile/controller/profile_binding.dart';
import 'package:apnidhukan/profile/presentation/profile_screen.dart';
import 'package:apnidhukan/user_address/controller/address_binding.dart';
import 'package:apnidhukan/user_address/presentation/address_screen.dart';
import 'package:get/get.dart';

import '../../orders_history/controller/order_history_binding.dart';
import '../../orders_history/presentation/order_history_screen.dart';

class NavPages {
  static final pages = [
    GetPage(
      name: NavRoutes.mainScreenRoute,
      page: () => MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: NavRoutes.productsRoute,
      page: () => ProductsScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: NavRoutes.cartRoute,
      page: () => CartsScreen(),
      binding: CartsBinding(),
    ),
    GetPage(
      name: NavRoutes.profileRoute,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: NavRoutes.wishlistRoute,
      page: () => WishlistScreen(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: NavRoutes.productDetailsRoute,
      page: () => ProductsDetailsScreen(),
      binding: ProductsDetailsBinding(),
    ),
    GetPage(
      name: NavRoutes.checkoutRoute,
      page: () => CheckoutScreen(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: NavRoutes.paymentsRoute,
      page: () => PaymentScreen(),
      binding: PaymentBindings(),
    ),
    GetPage(
      name: NavRoutes.ordersHistoryRoute,
      page: () => OrderHistoryScreen(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: NavRoutes.addressRoute,
      page: () => AddressScreen(),
      binding: AddressBinding(),
    ),


  ];
}
