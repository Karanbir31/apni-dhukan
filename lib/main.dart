import 'package:apnidhukan/core/app_const/my_app_theme.dart';
import 'package:apnidhukan/main_screen/presentation/main_screen.dart';
import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:apnidhukan/products_checkout/controller/checkout_controller.dart';
import 'package:apnidhukan/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    final appTheme = MyAppTheme(textTheme);

    return GetMaterialApp(
      title: "Apni Dukan",
      onInit: () {
        Get.lazyPut(() => CartsController());
        Get.lazyPut(() => ProductsController());
        Get.lazyPut(() => CheckoutController());
        Get.lazyPut(() => ProfileController());
      },

      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(microseconds: 200),
      debugShowCheckedModeBanner: false,
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),

      home: MainScreen(),
    );
  }
}
