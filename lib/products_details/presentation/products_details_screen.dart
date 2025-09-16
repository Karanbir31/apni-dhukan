import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products/domain/product_item.dart';
import '../controller/products_details_controller.dart';

class ProductsDetailsScreen extends StatelessWidget {
  ProductsDetailsScreen({super.key});

  final controller = Get.put(ProductsDetailsController());
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = context.theme;

    final args = Get.arguments as Map<String, dynamic>;
    final product = args['data'] as ProductItem;
    controller.setProduct(product);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. SliverAppBar with Product Image + Actions
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              elevation: 8.0,
              shadowColor: theme.colorScheme.onPrimaryContainer.withValues(
                alpha: 0.33,
              ),
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "product-hero",
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.network(
                          controller.product.images[0] ??
                              "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp",
                          fit: BoxFit.fitHeight,
                        ),
                      ),

                      Positioned(
                        left: 4,
                        bottom: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${controller.product.rating} | 1.2k",
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                // Wishlist Button
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

                // Cart Badge
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                ),
              ],
            ),

            // 2. Product Name, Description, Price
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.product.brand,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.product.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          "₹ ${controller.product.price.toStringAsFixed(2)}",

                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(width: 16.0),

                        Icon(Icons.arrow_downward, color: Colors.green),

                        const SizedBox(width: 4.0),

                        Text(
                          "${controller.product.discountPercentage}% off",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      controller.product.description,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),

            // 4. Delivery details
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      "Delivery Details",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.updateDeliveryAddress();
                      },

                      child: _deliverDetails(
                        Icons.home,
                        "Home",
                        "Phase 5, Mohali, Punjab 143410",
                      ),
                    ),
                    _deliverDetails(
                      Icons.shopping_cart,
                      "Free Delivery in 7 days",
                      null,
                    ),
                  ],
                ),
              ),
            ),

            // 5. Features Row (Return, Warranty, COD)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFeature(Icons.replay, "10 days return"),
                    _buildFeature(Icons.verified, "1 year warranty"),
                    _buildFeature(Icons.payment, "Cash on delivery"),
                  ],
                ),
              ),
            ),

            // 6. Extra Section (Placeholder for reviews / details)
            SliverToBoxAdapter(
              child: Padding(
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
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(height: Get.height * 0.2),
            ),
          ],
        ),
      ),

      // Bottom Bar with Actions
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
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
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Text(
                    controller.isAddedToCart.value
                        ? "Go to cart"
                        : "Add to Cart",
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  List<CartProduct> checkoutItem = [
                    CartProduct(productItem: controller.product, quantity: 1),
                  ];

                  controller.navigateToCheckout(checkoutItem);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliverDetails(IconData icon, String label, String? value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: EdgeInsets.only(top: 2.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceTint.withValues(alpha: 0.01),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4.0),
          if (value != null)
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
