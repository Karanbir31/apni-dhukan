import 'package:apnidhukan/orders_history/controller/orders_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products_cart/presentation/ui/carts_products_card.dart';

class OrderHistoryScreen extends GetView<OrdersHistoryController> {

  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getOrdersHistory();

    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(theme),

            /// 🟦 SliverList with grouped dates + orders
            Obx(() {
              final dates = controller.orderHistory.keys.toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, dateIndex) {
                  final date = dates[dateIndex];
                  final orders = controller.orderHistory[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Date heading
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          color: theme.colorScheme.primaryContainer,
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            date, // already in YYYY-MM-DD format
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),

                      /// Orders list under this date
                      ...orders.map((orderItem) {
                        return CartsProductsCard(
                          cartItem: orderItem.cartProduct,
                          isQuantityMenuVisible: false,
                        );
                      }),
                    ],
                  );
                }, childCount: dates.length, ),
              );
            }),

            SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(height: Get.height * 0.2),
            ),
          ],
        ),
      ),
    );
  }

  /// 🟦 AppBar
  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        "Order History",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
