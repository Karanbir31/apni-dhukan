import 'package:apnidhukan/core/app_const/my_app_theme.dart';
import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products/presentation/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.light().textTheme;
    final appTheme = MyAppTheme(textTheme);

    return GetMaterialApp(
      title: "Apni Dukan",
      onInit: () {
        Get.lazyPut(() => ProductsController());
      },

      debugShowCheckedModeBanner: false,
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),

      home: ProductsScreen(),
    );
  }
}
