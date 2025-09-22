import 'package:apnidhukan/core/local_db/address/address_dao.dart';
import 'package:apnidhukan/core/nav_routes/nav_helper.dart';
import 'package:apnidhukan/products/data/products_repository.dart';
import 'package:apnidhukan/products/domain/category.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:apnidhukan/products/presentation/ui_widgets/products_filter_bottom_sheet.dart';
import 'package:apnidhukan/user_address/modules/address_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../user_address/presentation/address_bottom_sheets/select_address_bottom_sheet.dart';

class ProductsController extends GetxController {
  final _repository = ProductsRepository();

  RxBool isCategoriesAppBarCollapsed = false.obs;
  RxInt topSliverBarSelectedIdx = 1.obs;

  RxList<ProductItem> products = <ProductItem>[].obs;

  RxList<Category> categories = <Category>[].obs;
  RxInt selectedCategoryIndex = 0.obs;

  Rx<AddressItem> defaultAddress = AddressItem(
    name: "",
    contact: "",
    shortAddress: "",
    fullAddress: "",
    latLng: LatLng(0.0, 0.0),
  ).obs;

  ScrollController categoryScrollController = ScrollController();

  TextEditingController searchTextController = TextEditingController();

  Rx<SortByOption?> selectedSortOption = Rx<SortByOption?>(null);

  void selectSortOption(SortByOption? option) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    selectedSortOption.value = option;

    switch (option) {
      case SortByOption.popularity:
        showSnackBar("Popularity");
        break;

      case SortByOption.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
        products.refresh();
        break;

      case SortByOption.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
        products.refresh();
        break;

      case SortByOption.title:
        products.sort((a, b) => a.title.compareTo(b.title));
        products.refresh();
        break;

      case SortByOption.discount:
        products.sort(
          (a, b) => b.discountPercentage.compareTo(a.discountPercentage),
        );
        products.refresh();
        break;

      case null:
        break;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedCategoryIndex.value = -1;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getProducts();
    getCategories();

    scrollCategoryList();
    getAddress();
  }

  Future<void> getProducts() async {
    final result = await _repository.getProducts();

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

    categories.clear();
    for (var c in result) {
      final url = await _repository.getCategoryThumbnail(c.url);
      c.setImageUrl(url ?? "https://cdn.dummyjson.com/public/qr-code.png");

      categories.add(c);
    }
  }

  Future<void> searchProducts(String query) async {
    searchTextController.text = query;

    await getProductsWithQuery(query.trim());
  }

  Future<void> getAddress() async {
    final address = await AddressDao.getDefaultAddress();

    if (address != null) {
      defaultAddress.value = address;
    }
  }

  void updateCategoriesAppBarState({required bool value}) {
    isCategoriesAppBarCollapsed.value = value;
  }

  void updateTopSliverBarSelectedIdx({required int idx}) {
    topSliverBarSelectedIdx.value = idx;
  }

  void navigateToProductsDetails(ProductItem productItem) {
    NavHelper.toProductDetails(productItem);
  }

  void showFilterBottomSheet(ThemeData theme) {
    Get.bottomSheet(
      ProductsFilterBottomSheet(),
      elevation: 4.0,
      backgroundColor: theme.colorScheme.surface,
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  void showAddressBottomSheet() {
    Get.bottomSheet(
      SelectAddressBottomSheet(),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,

      //backgroundColor: theme.colorScheme.surface,
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  void showSnackBar(String? text) {
    Get.snackbar(
      text ?? "Categories Sliver bar is in pinned stated",
      "",
      backgroundColor: Colors.grey,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: DismissDirection.down,
      duration: Duration(seconds: 2),
    );
  }
}
