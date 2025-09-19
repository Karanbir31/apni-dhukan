import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. Define an enum for your sorting options
enum SortByOption {
  popularity,
  priceLowToHigh,
  priceHighToLow,
  title,
  discount,
}

class ProductsFilterBottomSheet extends StatelessWidget {
  ProductsFilterBottomSheet({super.key});

  final controller = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            // Added padding for better layout
            child: Text(
              "SORT BY",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Divider(color: theme.colorScheme.onSurface.withOpacity(0.7)),

          // 3. Use Obx to rebuild when selectedSortOption changes
          Obx(
            () => Column(
              children: SortByOption.values.map((option) {
                String optionText = _getOptionText(option);
                return _buildSortingRadioListTile(
                  optionText,
                  option,
                  controller.selectedSortOption.value,
                  (newValue) => controller.selectSortOption(newValue),
                  theme,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get the display text for each enum option
  String _getOptionText(SortByOption option) {
    switch (option) {
      case SortByOption.popularity:
        return "Popularity";
      case SortByOption.priceLowToHigh:
        return "Price -- low to high";
      case SortByOption.priceHighToLow:
        return "Price -- high to low";
      case SortByOption.title:
        return "Title";
      case SortByOption.discount:
        return "Discount";
    }
  }

  // Helper widget to build each RadioListTile
  Widget _buildSortingRadioListTile(
    String title,
    SortByOption value,
    SortByOption? groupValue,
    ValueChanged<SortByOption?> onChanged,
    ThemeData theme,
  ) {
    return RadioListTile<SortByOption>(
      title: Text(title, style: theme.textTheme.titleMedium),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,

      controlAffinity: ListTileControlAffinity
          .trailing,
    );
  }
}
