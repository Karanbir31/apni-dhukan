import 'package:apnidhukan/core/app_const/app_assets.dart';
import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/products_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TopSearchSliverBar extends StatelessWidget {
  final ProductsController productsController;

  const TopSearchSliverBar({super.key, required this.productsController});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SliverAppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0)),
      ),
      clipBehavior: Clip.antiAlias,
      shadowColor: theme.shadowColor,
      expandedHeight: 120,
      toolbarHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,

      // Search bar at bottom
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 12.0,
            right: 12.0,
            bottom: 16.0,
          ),
          child: Row(
            children: [
              Flexible(child: _searchField(theme, context)),
              InkWell(
                onTap: () {
                  productsController.showFilterBottomSheet(theme);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAssets.sorting,
                    width: 32,
                    height: 32,

                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      flexibleSpace: FlexibleSpaceBar(
        background: InkWell(
          onTap: productsController.showAddressBottomSheet,

          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              color: theme.colorScheme.primary,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(
                            () => Text(
                              productsController.defaultAddress.value.id == null
                                  ? "Enter Address ..."
                                  : productsController.defaultAddress.value
                                        .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔍 Search field widget
  Widget _searchField(ThemeData theme, BuildContext context) {
    return TextField(
      controller: productsController.searchTextController,
      maxLines: 1,
      readOnly: true,
      onTap: () async {
        String? query = await showSearch(
          context: context,
          delegate: ProductsSearchBar(
            controller: productsController,
            theme: theme,
          ),
        );

        if (query != null && query.isNotEmpty) {
          productsController.searchProducts(query.trim());
        }
      },
      cursorColor: theme.colorScheme.primary,
      style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
      decoration: InputDecoration(
        hintText: "Search products...",
        hintStyle: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
        suffixIcon: IconButton(
          icon: Icon(Icons.mic, color: theme.colorScheme.primary),
          onPressed: () {},
        ),
        prefixIcon: IconButton(
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: ProductsSearchBar(
                controller: productsController,
                theme: theme,
              ),
            );
          },
          icon: Icon(Icons.search, color: theme.colorScheme.primary),
        ),
        filled: true,
        fillColor: theme.colorScheme.onPrimary,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onPrimary),
        ),
      ),
    );
  }
}
