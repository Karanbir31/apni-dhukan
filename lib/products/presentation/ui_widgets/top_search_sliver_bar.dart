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
        background: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            color: theme.colorScheme.primary,
          ),
          child: Column(
            children: [
              /***
               *  Flexible(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Obx(
                  () => Row(
                  children: [
                  Expanded(
                  child: _buildOption(
                  theme: theme,
                  label: "Box 1",
                  isSelected: productsController.topSliverBarSelectedIdx.value == 1,
                  onClick: () => productsController.updateTopSliverBarSelectedIdx(idx: 1),
                  ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                  child: _buildOption(
                  theme: theme,
                  label: "Box 2",
                  isSelected: productsController.topSliverBarSelectedIdx.value == 2,
                  onClick: () => productsController.updateTopSliverBarSelectedIdx(idx: 2),
                  ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                  child: _buildOption(
                  theme: theme,
                  label: "Box 3",
                  isSelected: productsController.topSliverBarSelectedIdx.value == 3,
                  onClick: () => productsController.updateTopSliverBarSelectedIdx(idx: 3),
                  ),
                  ),
                  ],
                  ),
                  ),
                  ),
                  ),
               */
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: theme.colorScheme.onPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Phase 5, sector 59, Mohali, Punjab",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
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
            ],
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

  /// 🟦 Option box with icon + text
  Widget _buildOption({
    required ThemeData theme,
    required String label,
    required bool isSelected,
    required VoidCallback onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onPrimary.withValues(alpha: 0.5),
          border: Border.all(
            color: theme.colorScheme.onPrimaryContainer,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: theme.colorScheme.onPrimaryContainer),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
