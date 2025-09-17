import 'package:apnidhukan/products/presentation/ui_widgets/product_card.dart';
import 'package:apnidhukan/products_wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("WishList")),

            SliverToBoxAdapter(child: _buildLoader(theme)),
            SliverToBoxAdapter(child: _buildEmptyScreen(theme)),

            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = controller.wishlist[index];
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ProductCard(product: product),

                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              controller.onPressRemove(product);
                            },
                            icon: Icon(Icons.favorite, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  );
                }, childCount: controller.wishlist.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Loader widget
  Widget _buildEmptyScreen(ThemeData theme) {
    return Obx(() {
      if (controller.wishlist.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Wish list is empty",
              style: theme.textTheme.titleLarge,
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  /// Loader widget
  Widget _buildLoader(ThemeData theme) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
