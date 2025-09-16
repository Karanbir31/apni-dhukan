import 'package:apnidhukan/products_checkout/controller/checkout_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/helper/price_helper.dart';
import '../../products_cart/modules/cart_product.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCartProductItem(index, theme),
                  childCount: controller.cartData.length,
                ),
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
      child: Column(
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
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                  ),
                  onPressed: controller.changeDeliveryAddress,
                  child: const Text("Change"),
                ),
              ],
            ),
          ),
          _addressLine("Karanbir Singh", theme),
          _addressLine("+91 9876543210", theme),
          _addressLine("Hno 182, phase 5, sector 59, Mohali, Punjab", theme),
          Divider(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
          ),
        ],
      ),
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

  /// 🛒 Cart Product Item
  Widget _buildCartProductItem(int index, ThemeData theme) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      child: Obx(() {
        final cartItem = controller.cartData[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _productImage(cartItem.productItem.images[0], theme),
            ),
            const SizedBox(width: 12),
            Expanded(child: _productDetails(cartItem, theme, index)),
          ],
        );
      }),
    );
  }

  Widget _productImage(String url, ThemeData theme) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48, maxWidth: 84),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  Widget _productDetails(CartProduct cartItem, ThemeData theme, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          Text(
            cartItem.productItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          _ratingRow(theme, cartItem),

          _buildPriceRow(theme, cartItem),

          Text("Qty: ${cartItem.quantity}", style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }

  /// Price Row
  Widget _buildPriceRow(ThemeData theme, CartProduct cartItem) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_downward, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            Text(
              "${cartItem.productItem.discountPercentage}% off",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          "₹ ${PriceHelper.roundOffPrice(cartItem.productItem.price * cartItem.quantity)}",
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }

  /// Rating Row
  Widget _ratingRow(ThemeData theme, CartProduct cartProduct) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          "${cartProduct.productItem.rating} | 1.2k",
          style: theme.textTheme.bodyMedium,
        ),
      ],
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
