import 'package:apnidhukan/main_screen/controller/main_screen_controller.dart';
import 'package:apnidhukan/products_cart/presentation/carts_screen.dart';
import 'package:apnidhukan/products_details/presentation/products_details_screen.dart';
import 'package:apnidhukan/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products/presentation/products_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_rounded),
        label: "Cart",
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
    ];

    List<Widget> bottomNavScreens = [
      ProductsScreen(),
      CartsScreen(),
      ProfileScreen(),
      ProductsDetailsScreen(),
    ];

    return Scaffold(
      body: Obx(() => bottomNavScreens[controller.bottomNavSelectedIdx.value]),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(

          items: bottomNavItems,
          elevation: 8,
          useLegacyColorScheme: true,
          backgroundColor: colorScheme.secondaryContainer,
          onTap: controller.updateBottomNavSelectedIdx,

          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: controller.bottomNavSelectedIdx.value,
          type: BottomNavigationBarType.fixed,

          selectedIconTheme: IconThemeData(
            color: colorScheme.primary,
            size: 32,
          ),
          unselectedIconTheme: IconThemeData(
            color: colorScheme.onSecondaryContainer,
            size: 24,
          ),

          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSecondaryContainer,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
