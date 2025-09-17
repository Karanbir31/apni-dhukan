import 'package:apnidhukan/products/data/products_repository.dart';
import 'package:apnidhukan/products/domain/category.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/products_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../products_details/presentation/products_details_screen.dart';

class ProductsController extends GetxController {
  final _repository = ProductsRepository();

  RxBool isCategoriesAppBarCollapsed = false.obs;
  RxInt topSliverBarSelectedIdx = 1.obs;

  RxList<ProductItem> products = <ProductItem>[].obs;

  RxList<Category> categories = <Category>[].obs;
  RxInt selectedCategoryIndex = 0.obs;

  ScrollController categoryScrollController = ScrollController();

  TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedCategoryIndex.value = -1;

    getProducts();
    getCategories();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    scrollCategoryList();
  }

  Future<void> getProducts() async {
    final result = await _repository.getProducts();
    // add new products list in rxList products

    products.addAll(result);
  }

  Future<void> getProductsWithCategory(String categoryUrl) async {
    products.clear();
    final result = await _repository.getProductsWithCategory(categoryUrl);
    products.addAll(result);
  }

  Future<void> getProductsWithQuery(String query) async {
    products.clear();
    final result = await _repository.getProductsWithQuery(query);
    products.addAll(result);
  }

  Future<void> updateSelectedCategory(int index) async {
    selectedCategoryIndex.value = index;
    scrollCategoryList();
    await getProductsWithCategory(categories[index].url);
  }

  void scrollCategoryList() {
    // Scroll to tapped category
    if (categoryScrollController.hasClients) {
      categoryScrollController.animateTo(
        selectedCategoryIndex.value * 72.0,
        // <-- adjust item width as per your UI
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> getCategories() async {
    final result = await _repository.getCategoriesList();
    // add new products list in rxList products

    categories.clear();
    for (var c in result) {
      final url = await _repository.getCategoryImageUrl(c.url);
      c.setImageUrl(url ?? "https://cdn.dummyjson.com/public/qr-code.png");

      categories.add(c);
    }
  }

  Future<void> searchProducts(String query) async {
    searchTextController.text = query;

    await getProductsWithQuery(query.trim());
  }

  void updateCategoriesAppBarState({required bool value}) {
    isCategoriesAppBarCollapsed.value = value;
  }

  void updateTopSliverBarSelectedIdx({required int idx}) {
    topSliverBarSelectedIdx.value = idx;
  }

  void navigateToProductsDetails(ProductItem productItem) {
    Get.to(ProductsDetailsScreen(), arguments: {'data': productItem});
  }

  void showFilterBottomSheet(ThemeData theme) {
    Get.bottomSheet(
      ProductsFilterBottomSheet(),
      elevation: 4.0,
      backgroundColor: theme.colorScheme.surface,
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true

    );
  }

  void showSnackBar() {
    Get.snackbar(
      "Categories Sliver bar is in pinned stated",
      "",
      backgroundColor: Colors.grey,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.down,
      duration: Duration(seconds: 2),
    );
  }
}
