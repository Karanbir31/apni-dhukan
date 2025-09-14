import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartsScreen extends GetView<CartsController> {
  CartsScreen({super.key});

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = context.theme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.colorScheme.primary,

            title: Text(
              "My Cart",
              style: TextStyle(
                fontSize: 20,
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),

            bottom: PreferredSize(
              preferredSize: Size(Get.width, 56),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Phase 5, sector 59, Mohali, Punjab",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverFillRemaining(),
        ],
      ),
    );
  }
}
