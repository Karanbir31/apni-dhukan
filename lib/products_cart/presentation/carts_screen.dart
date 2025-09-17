import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/helper/price_helper.dart';

class CartsScreen extends GetView<CartsController> {
  const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
                  return _buildCartProductItem(cartItem, theme);
                },
              ),
            ),
            SliverToBoxAdapter(child: Obx(() => _buildCartSummary(theme))),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => _buildBottomBar(theme)),
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

  /// ---------------- CART PRODUCT ITEM ----------------
  Widget _buildCartProductItem(CartProduct cartItem, ThemeData theme) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => controller.navigateToProductsDetails(cartItem.productItem),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(cartItem, theme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductTitle(cartItem, theme),
                    const SizedBox(height: 4),
                    _ratingRow(theme, cartItem),
                    const SizedBox(height: 4),
                    _buildPriceRow(theme, cartItem),
                    //  const SizedBox(height: 8),
                    // _buildQuantityDropdown(cartItem),
                    const SizedBox(height: 12),
                    _buildActionButtons(cartItem, theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(CartProduct cartItem, ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12.0,
      children: [
        Container(
          width: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            cartItem.productItem.images.first,
            fit: BoxFit.cover,
          ),
        ),

        _buildQuantityDropdown(cartItem, theme),
      ],
    );
  }

  Widget _buildProductTitle(CartProduct cartItem, ThemeData theme) {
    return Text(
      cartItem.productItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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

  Widget _buildQuantityDropdown(CartProduct cartItem, ThemeData theme) {
    return Row(
      children: [
        Text("Qty: ${cartItem.quantity} ", style: theme.textTheme.bodyMedium),
        const SizedBox(width: 8),
        DropdownMenu<int>(
          initialSelection: cartItem.quantity,
          enableSearch: false,
          menuHeight: 150,
          width: 60,
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            border: InputBorder.none,
          ),
          onSelected: (value) {
            if (value != null) {
              controller.updateQuantity(cartItem.productItem.id, value);
            }
          },
          dropdownMenuEntries: List.generate(
            10,
            (i) => DropdownMenuEntry(value: i + 1, label: "${i + 1}"),
          ),
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

  Widget _buildActionButtons(CartProduct cartItem, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => controller.removeFromCart(cartItem.productItem.id),
            child: const Text("Remove"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondaryContainer,
              foregroundColor: theme.colorScheme.onSecondaryContainer,
            ),

            onPressed: () => controller.navigateToCheckout([cartItem]),
            child: const Text("Buy Now"),
          ),
        ),
      ],
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
                      child: Text(
                        "${item.productItem.price.toStringAsFixed(2)}",
                      ),
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
      if (controller.cart.isEmpty) {
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
