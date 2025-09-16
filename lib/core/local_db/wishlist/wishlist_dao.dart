import 'package:apnidhukan/core/local_db/db_provider.dart';
import 'package:apnidhukan/core/local_db/wishlist/wishlist_table.dart';
import 'package:apnidhukan/products/domain/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class WishlistDao {
  static final _tag = "WishlistDao";

  // add a product to add to wishlist
  static Future<int> insertProduct(ProductItem product) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      return await db.insert(
        WishlistTable.tableName,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      debugPrint("$_tag error in insert function ==== $error");
      return 0;
    }
  }

  // read full wishlist data
  static Future<List<ProductItem>> getWishlistProducts() async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      final response = await db.query(WishlistTable.tableName);

      final data = response.map((item) => ProductItem.fromJson(item)).toList();

      return data;
    } catch (error) {
      debugPrint("$_tag error in get wishlist products function ====> $error");
      return [];
    }
  }

  // delete/remove a product from wishlist
  static Future<int> deleteProduct(int id) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      return await db.delete(
        WishlistTable.tableName,
        where: '${WishlistTable.columnProductId} = ?',
        whereArgs: [id],
      );
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return 0;
    }
  }

  // delete/remove a product from wishlist
  static Future<void> deleteProducts(List<ProductItem> wishlist) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      for (var item in wishlist) {
        await db.delete(
          WishlistTable.tableName,
          where: '${WishlistTable.columnProductId} = ?',
          whereArgs: [item.id],
        );
      }
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return ;
    }
  }

  static Future<bool> isPresentInWishlist(int productId) async {
    final db = await DbProvider.getDataBaseInstance();
    final result = await db.query(
      WishlistTable.tableName,
      columns: [WishlistTable.columnProductId],
      where: '${WishlistTable.columnProductId} = ?',
      whereArgs: [productId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
