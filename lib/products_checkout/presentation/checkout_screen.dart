import 'package:apnidhukan/products_cart/presentation/ui/carts_products_card.dart';
import 'package:apnidhukan/products_checkout/controller/checkout_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products_cart/modules/cart_product.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    controller.getAddress();

    // ✅ Get products from arguments
    final arguments = Get.arguments;
    if (arguments != null) {
      final List<CartProduct> cartsProducts = arguments['data'];
      if (cartsProducts.isNotEmpty) {
        controller.setCartsProducts(cartsProducts);
      }
    } else {
      Get.back();
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(theme),
            _buildDeliveryAddress(theme),
            _buildShoppingBagLabel(theme),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final cartItem = controller.cartData[index];

                  return CartsProductsCard(
                    cartItem: cartItem,
                    isQuantityMenuVisible: false,
                  );
                }, childCount: controller.cartData.length),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: _buildBottomBar(theme)),
    );
  }

  /// 🟦 AppBar
  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        "Order Summary",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  /// 📍 Delivery Address
  Widget _buildDeliveryAddress(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.defaultAddress.value.isAddressNull()) {
          return SizedBox(
            height: 84,
            width: Get.width * 0.8,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: controller.showAddressBottomSheet,
                child: const Text("Select a delivery address"),
              ),
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Address",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      onPressed: controller.showAddressBottomSheet,
                      child: const Text("Change"),
                    ),
                  ],
                ),
              ),

              _addressLine(controller.defaultAddress.value.name, theme),
              _addressLine(controller.defaultAddress.value.contact, theme),
              _addressLine(controller.defaultAddress.value.toString(), theme),
              Divider(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.3,
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _addressLine(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 🛍 Shopping Bag Label
  Widget _buildShoppingBagLabel(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          "Shopping bag",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 💳 Bottom Bar
  Widget _buildBottomBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _totalPrice(theme),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: controller.payAndCheckOut,
              child: const Text("Pay now"),
            ),
          ],
        );
      }),
    );
  }

  Widget _totalPrice(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}
