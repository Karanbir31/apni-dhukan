import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsSearchBar extends SearchDelegate<String> {
  final ProductsController controller;
  final ThemeData theme;

  ProductsSearchBar({required this.controller, required this.theme});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return query to caller instead of popping directly
    close(context, query);
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.trim().isEmpty
        ? controller.products
        : controller.products
              .where(
                (item) => (item.title ?? '').toLowerCase().contains(
                  query.trim().toLowerCase(),
                ),
              )
              .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            close(context, "");
          },
          child: ProductCard(product: suggestionList[index]),
        );
      },
    );
  }
}
