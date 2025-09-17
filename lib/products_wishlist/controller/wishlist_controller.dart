import 'package:apnidhukan/core/local_db/db_provider.dart';
import 'package:apnidhukan/core/local_db/wishlist/wishlist_dao.dart';
import 'package:apnidhukan/core/local_db/wishlist/wishlist_table.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  RxList<ProductItem> wishlist = <ProductItem>[].obs;
  RxBool isLoading = false.obs;

  // we trigger this function inside main screen where we implement bottom nav bar
  Future<void> getWishlist() async {
    isLoading.value = true;
    wishlist.clear();
    final response = await WishlistDao.getWishlistProducts();

    isLoading.value = false;
    wishlist.addAll(response);
  }

  Future<void> onPressRemove(ProductItem product) async {
    wishlist.remove(product);

    await WishlistDao.deleteProduct(product.id);
  }

  Future<void> printTableSchema() async {
    final db = await DbProvider.getDataBaseInstance();
    final tableName = WishlistTable.tableName;

    final List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;",
    );

    for (var table in tables) {
      debugPrint("Table: ${table['name']}");
    }

    final columns = await db.rawQuery("Select * from $tableName;");

    debugPrint("data in  of $tableName:");
    for (var col in columns) {
      debugPrint("$columns");
    }
  }
}
