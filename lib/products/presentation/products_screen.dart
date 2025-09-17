import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/product_card.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/top_search_sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(child: _buildBody(theme)),
    );
  }

  Widget _buildBody(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        TopSearchSliverBar(productsController: controller),

        _sliverAppBarSpacer(theme),

        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          sliver: _categoriesSliverTopBar(theme),
        ),

        _sliverAppBarSpacer(theme),

        // SliverToBoxAdapter(child: SizedBox(height: 16.0,)),

        // Loader
        SliverToBoxAdapter(child: _buildLoader(theme)),

        // Product list
        Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  ProductCard(product: controller.products[index]),
              childCount: controller.products.length,
            ),
          ),
        ),

        const SliverFillRemaining(
          hasScrollBody: false,
          child: SizedBox(height: 120),
        ),
      ],
    );
  }

  /// Loader widget
  Widget _buildLoader(ThemeData theme) {
    return Obx(() {
      if (controller.products.isEmpty) {
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

  /// Categories SliverAppBar
  Widget _categoriesSliverTopBar(ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 110,
      toolbarHeight: 40,
      backgroundColor: theme.colorScheme.surface,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          bool isCollapsed = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isCollapsed =
                constraints.maxHeight <= kToolbarHeight + kToolbarHeight / 3;
            controller.updateCategoriesAppBarState(value: isCollapsed);
          });

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 8),
            title: SizedBox(
              height: 64, // reduced overall size
              child: Obx(
                () => ListView.builder(
                  controller: controller.categoryScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return _categoryItem(
                      theme,
                      category.name,
                      category.imageUrl ??
                          "https://cdn.dummyjson.com/public/qr-code.png",
                      isSelected:
                          index == controller.selectedCategoryIndex.value,
                      onClick: () {
                        controller.updateSelectedCategory(index);
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Single Category Item
  Widget _categoryItem(
    ThemeData theme,
    String name,
    String imageUrl, {
    required bool isSelected,
    required void Function() onClick,
  }) {
    return Obx(() {
      bool isCollapsed = controller.isCategoriesAppBarCollapsed.value;
      return Container(
        width: 72,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.7)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: InkWell(
          onTap: onClick,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isCollapsed)
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Image.network(
                      imageUrl,
                      height: 32, // smaller image
                      width: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isCollapsed ? 12 : 11,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Tiny spacer SliverAppBar
  Widget _sliverAppBarSpacer(ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 16,
      backgroundColor: theme.colorScheme.surface,
    );
  }
}
