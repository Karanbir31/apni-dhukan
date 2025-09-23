import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  RxInt bottomNavSelectedIdx = 0.obs;

  final productsScreenInx = 0;
  final cartsScreenIdx = 1;
  final profileScreenIdx = 2;
  final wishListScreenIdx = 3;

  void navigate(int idx) {
    bottomNavSelectedIdx.value = idx;
  }

  Future<bool> showExitConfirmDialog() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: true),  // Confirm exit
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel
            child: const Text('No'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

}
