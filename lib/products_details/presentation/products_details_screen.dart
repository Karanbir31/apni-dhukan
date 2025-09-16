import 'package:apnidhukan/core/helper/price_helper.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products/domain/product_item.dart';
import '../controller/products_details_controller.dart';

class ProductsDetailsScreen extends StatelessWidget {
  ProductsDetailsScreen({super.key});

  final controller = Get.put(ProductsDetailsController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final args = Get.arguments as Map<String, dynamic>;
    final product = args['data'] as ProductItem;
    controller.setProduct(product);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _productHeader(theme),
            SliverToBoxAdapter(child: _productInfo(theme)),
            SliverToBoxAdapter(child: _deliverySection(theme)),
            SliverToBoxAdapter(child: _featuresRow(theme)),
            SliverToBoxAdapter(child: _moreDetails(theme)),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar(theme),
    );
  }

  /// 1. Product image + app bar
  Widget _productHeader(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      elevation: 3,
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: "product-hero",
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Image.network(
                  controller.product.images.first,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      "${controller.product.rating} | 1.2k",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isFavorite.value
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: controller.isFavorite.value ? Colors.red : null,
            ),
            onPressed: controller.updateIsFavorite,
          );
        }),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            controller.navigateToCartScreen();
          },
        ),
      ],
    );
  }

  /// 2. Product brand, name, price, description
  Widget _productInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.product.brand,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.product.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              // Original price (strikethrough)
              Text(
                "₹ ${PriceHelper.getOriginalPrice(controller.product.price, controller.product.discountPercentage)}",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              const SizedBox(width: 12.0),

              // Final (discounted) price
              Text(
                "₹ ${PriceHelper.roundOffPrice(controller.product.price)}",
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 12.0),

              // Discount percentage
              Text(
                "${controller.product.discountPercentage}% off",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            controller.product.description,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  /// 3. Delivery section
  Widget _deliverySection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Details",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: controller.updateDeliveryAddress,
            child: _deliveryTile(
              theme,
              Icons.home,
              "Home",
              "Phase 5, Mohali, Punjab 143410",
            ),
          ),
          _deliveryTile(theme, Icons.shopping_cart, "Free Delivery", "7 days"),
        ],
      ),
    );
  }

  Widget _deliveryTile(
    ThemeData theme,
    IconData icon,
    String label,
    String? value,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(label, style: theme.textTheme.bodyLarge),
        subtitle: value != null ? Text(value) : null,
      ),
    );
  }

  /// 4. Features (return, warranty, COD)
  Widget _featuresRow(ThemeData theme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _featureItem(theme, Icons.replay, "10 days return"),
            _featureItem(theme, Icons.verified, "1 year warranty"),
            _featureItem(theme, Icons.payment, "Cash on delivery"),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(ThemeData theme, IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(height: 4),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }

  /// 5. More details placeholder
  Widget _moreDetails(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More Details",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Here you can add more detailed product description, specifications, or customer reviews.",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// 6. Bottom action bar
  Widget _bottomBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  controller.isAddedToCart.value
                      ? controller.navigateToCartScreen()
                      : controller.addToCart();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  controller.isAddedToCart.value ? "Go to Cart" : "Add to Cart",
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final checkoutItem = [
                  CartProduct(productItem: controller.product, quantity: 1),
                ];
                controller.navigateToCheckout(checkoutItem);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}
