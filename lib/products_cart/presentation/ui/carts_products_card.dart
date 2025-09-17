import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/price_helper.dart';
import '../../modules/cart_product.dart';

class CartsProductsCard extends StatelessWidget {
  CartsProductsCard({
    super.key,
    required this.cartItem,
    required this.isQuantityMenuVisible,
  });

  final bool isQuantityMenuVisible;
  final CartProduct cartItem;

  final controller = Get.find<CartsController>();

  /// ---------------- CART PRODUCT ITEM ----------------
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
                    //_buildQuantityDropdown(cartItem, theme),
                    const SizedBox(height: 12),
                    if (isQuantityMenuVisible)
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

  /// ---------------- CART PRODUCT ITEM ----------------
  /// image column and quantity selector menu
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

  /// ---------------- CART PRODUCT ITEM ----------------
  /// title row
  Widget _buildProductTitle(CartProduct cartItem, ThemeData theme) {
    return Text(
      cartItem.productItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  /// ---------------- CART PRODUCT ITEM ----------------
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

  /// ---------------- CART PRODUCT ITEM ----------------
  /// Quantity row
  Widget _buildQuantityDropdown(CartProduct cartItem, ThemeData theme) {
    return Row(
      children: [
        Text("Qty: ${cartItem.quantity} ", style: theme.textTheme.bodyMedium),
        const SizedBox(width: 8),

        if (isQuantityMenuVisible)
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
}
