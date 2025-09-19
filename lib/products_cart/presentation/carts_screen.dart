import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:apnidhukan/products_cart/presentation/ui/carts_products_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartsScreen extends GetView<CartsController> {
  const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    controller.readCartData();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(theme),

            SliverToBoxAdapter(child: _buildLoader(theme)),
            SliverToBoxAdapter(child: _buildEmptyScreen(theme)),

            Obx(
              () => SliverList.builder(
                itemCount: controller.cart.length,
                itemBuilder: (context, index) {
                  final cartItem = controller.cart[index];
                  return CartsProductsCard(
                    cartItem: cartItem,
                    isQuantityMenuVisible: true,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: Obx(() => _buildCartSummary(theme))),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.cart.isNotEmpty
            ? _buildBottomBar(theme)
            : SizedBox.shrink(),
      ),
    );
  }

  /// ---------------- APP BAR ----------------
  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      toolbarHeight: 56,
      expandedHeight: 90,
      backgroundColor: theme.colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "My Cart",
            style: TextStyle(
              fontSize: 24,
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(Get.width, 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(Icons.home, color: theme.colorScheme.onPrimary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Phase 5, sector 59, Mohali, Punjab",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- CART SUMMARY ----------------
  Widget _buildCartSummary(ThemeData theme) {
    if (controller.cart.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cart Summary",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(
              color: theme.colorScheme.surfaceTint.withValues(alpha: 0.3),
              width: 1.2,
              borderRadius: BorderRadius.circular(12),
            ),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              const TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8), child: Text("Product")),
                  Padding(padding: EdgeInsets.all(8), child: Text("Qty")),
                  Padding(padding: EdgeInsets.all(8), child: Text("PP")),
                  Padding(padding: EdgeInsets.all(8), child: Text("Price")),
                ],
              ),
              ...controller.cart.map(
                (item) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        item.productItem.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("${item.quantity}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item.productItem.price.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (item.productItem.price * item.quantity)
                            .toStringAsFixed(2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- BOTTOM BAR ----------------
  Widget _buildBottomBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // total price
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price:",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Row(
                children: [
                  Text(
                    "₹ ${controller.totalPrice.value.toStringAsFixed(2)}",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.info_circle,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // place order
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => controller.navigateToCheckout(controller.cart),
            child: const Text("Place Order"),
          ),
        ],
      ),
    );
  }

  /// Loader widget
  Widget _buildEmptyScreen(ThemeData theme) {
    return Obx(() {
      if (controller.cart.isEmpty && !controller.isLoading.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Cart list is empty",
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
