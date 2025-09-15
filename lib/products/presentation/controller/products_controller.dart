import 'package:apnidhukan/products/data/products_repository.dart';
import 'package:apnidhukan/products/domain/category.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final _repository = ProductsRepository();

  RxBool isCategoriesAppBarCollapsed = false.obs;
  RxInt topSliverBarSelectedIdx = 1.obs;

  RxList<ProductItem> products = <ProductItem>[].obs;

  RxList<Category> categories = <Category>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProducts();
    getCategories();
  }

  Future<void> getProducts() async {
    final result = await _repository.getProducts();
    // add new products list in rxList products

    products.addAll(result);
    update();
  }

  Future<void> getCategories() async {
    final result = await _repository.getCategoriesList();
    // add new products list in rxList products

    categories.clear();
    categories.addAll(result);
    update();
  }

  void updateCategoriesAppBarState({required bool value}) {
    isCategoriesAppBarCollapsed.value = value;
  }

  void updateTopSliverBarSelectedIdx({required int idx}) {
    topSliverBarSelectedIdx.value = idx;
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
