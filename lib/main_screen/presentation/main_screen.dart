import 'package:apnidhukan/main_screen/controller/main_screen_controller.dart';
import 'package:apnidhukan/products/presentation/products_screen.dart';
import 'package:apnidhukan/products_cart/presentation/carts_screen.dart';
import 'package:apnidhukan/products_wishlist/presentatation/wishlist_screen.dart';
import 'package:apnidhukan/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.put(MainScreenController());

  /// Bottom navigation items
  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
  ];

  /// Screens for each tab
  final List<Widget> _bottomNavScreens = [
    const ProductsScreen(),
    const CartsScreen(),
    ProfileScreen(),
    WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (controller.bottomNavSelectedIdx.value != 0) {
            controller.navigate(controller.productsScreenInx);
          } else {
            final shouldExit = await controller.showExitConfirmDialog();
            if (shouldExit) {
              SystemNavigator.pop();
            }
          }
        }
      },

      child: Scaffold(
        body: Obx(
          () => _bottomNavScreens[controller.bottomNavSelectedIdx.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _bottomNavItems,
            elevation: 8,

            currentIndex: controller.bottomNavSelectedIdx.value,
            onTap: _onNavItemTapped,

            showSelectedLabels: false,
            showUnselectedLabels: false,

            backgroundColor: colorScheme.primaryContainer,
            selectedIconTheme: IconThemeData(
              color: colorScheme.onPrimaryContainer,
              size: 32,
            ),
            unselectedIconTheme: IconThemeData(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  /// Handle tab navigation & data reloads
  void _onNavItemTapped(int index) {
    controller.navigate(index);
  }
}
