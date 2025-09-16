
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/price_helper.dart';

class ProductCard extends GetView<ProductsController> {
  final ProductItem product;

  const ProductCard({super.key, required this.product});



  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      elevation: 3,
      // subtle shadow
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => controller.navigateToProductsDetails(product),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _productImage(theme, product),
              const SizedBox(width: 12),
              Expanded(child: _productDetails(theme, product)),
            ],
          ),
        ),
      ),
    );
  }

  /// Product Image
  Widget _productImage(ThemeData theme, ProductItem product) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints(minHeight: 48, maxWidth: 80),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.network(product.images[0], fit: BoxFit.cover),
    );
  }

  /// Product Details
  Widget _productDetails(ThemeData theme, ProductItem product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        _ratingRow(theme, product),
        const SizedBox(height: 8),
        _priceRow(theme, product),
      ],
    );
  }

  /// Rating Row
  Widget _ratingRow(ThemeData theme, ProductItem product) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text("${product.rating} | 1.2k", style: theme.textTheme.bodyMedium),
      ],
    );
  }

  /// Price Row
  Widget _priceRow(ThemeData theme, ProductItem product) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: [
        Text(
          "₹ ${PriceHelper.getOriginalPrice(product.price, product.discountPercentage)}",
          style: theme.textTheme.bodySmall?.copyWith(
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_downward, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            Text(
              "${product.discountPercentage}% off",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          "₹ ${PriceHelper.roundOffPrice(product.price)}",
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }


}
