import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/top_search_sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends GetView<ProductsController> {
  ProductsScreen({super.key});

  ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    theme = context.theme;

    return Scaffold(body: SafeArea(child: productsScreenUi(context)));
  }

  Widget productsScreenUi(BuildContext context) {
    return CustomScrollView(
      slivers: [
        TopSearchSliverBar(),

        categoriesSliverTopBar(),

        SliverFillRemaining(),
      ],
    );
  }
  Widget categoriesSliverTopBar() {
    return SliverAppBar(
      floating: false,
      pinned: false,
      expandedHeight: 120,

      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final entry = controller.categories[index].entries.first;
              final icon = entry.key;
              final label = entry.value;

              return Container(
                width: 100, // fixed width for each item
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme!.colorScheme.primaryContainer.withValues(alpha: 0.33),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme!.colorScheme.primaryContainer,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
