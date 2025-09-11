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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme!.colorScheme.surface,
      body: SafeArea(child: productsScreenUi(context)),
    );
  }

  Widget productsScreenUi(BuildContext context) {
    return CustomScrollView(
      slivers: [
        TopSearchSliverBar(productsController: controller),

        mySliverAppBarSpacer(),

        // SliverAppBar(
        //   pinned: false,
        //   title: Text(
        //     "Products Categories",
        //     style: TextStyle(
        //       fontSize: 24,
        //       color: theme!.colorScheme.onSurface,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        categoriesSliverTopBar(),

        // SliverAppBar(
        //   pinned: false,
        //   title: Text(
        //     "Products",
        //     style: TextStyle(
        //       fontSize: 24,
        //       color: theme!.colorScheme.onSurface,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final currProducts = controller.dummyProducts[index];

            return productUiItem(currProducts);
          }, childCount: controller.dummyProducts.length),
        ),

        SliverFillRemaining(
          hasScrollBody: false,
          // fillOverscroll: false,
          child: SizedBox(height: 120),
        ),
      ],
    );
  }

  Widget productUiItem(Product product) {
    return Container(
      width: 84,
      margin: EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
      padding: EdgeInsets.all(12),

      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme!.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme!.colorScheme.primaryContainer,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.0,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              clipBehavior: Clip.hardEdge,
              constraints: BoxConstraints(
                minHeight: 48
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme!.colorScheme.onSurface.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
              ),
              child: Image.network(product.images[0], fit: BoxFit.fill),
            ),
          ),

          Flexible(
            flex: 4,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(12.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4.0,

                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "₹ ${product.price + 100}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesSliverTopBar() {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 180,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // Determine collapsed state
          final bool isCollapsed =
              constraints.maxHeight <= kToolbarHeight + kToolbarHeight / 2;
          controller.updateCategoriesAppBarState(value: isCollapsed);

          return FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            title: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final entry = controller.categories[index].entries.first;
                  final icon = entry.key;
                  final label = entry.value;

                  return Container(
                    width: 84,
                    margin: EdgeInsets.only(right: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: 0 == index
                          ? theme!.colorScheme.secondaryContainer.withValues(
                              alpha: 0.6,
                            )
                          : theme!.colorScheme.surface.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme!.colorScheme.primaryContainer,
                        width: 1.5,
                      ),
                    ),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4.0,
                        children: [
                          if (!controller.isCategoriesAppBarCollapsed.value)
                            Flexible(flex: 1, child: icon),

                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: isCollapsed ? 14 : 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mySliverAppBarSpacer() {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 12.0,

      backgroundColor: theme!.colorScheme.surface,
    );
  }
}
