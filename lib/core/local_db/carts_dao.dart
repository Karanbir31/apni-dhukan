import 'package:apnidhukan/core/local_db/carts_table.dart';
import 'package:apnidhukan/core/local_db/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../products_cart/modules/cart_product.dart';

class CartsDao {
  static final _tag = "CartsDao";

  // add a product to add cart
  static Future<int> insertCartProduct(CartProduct product) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      return await db.insert(
        CartsTable.tableName,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      debugPrint("$_tag error in insert function ==== $error");
      return 0;
    }
  }

  // read full cart data
  static Future<List<CartProduct>> getCartProducts() async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      final response = await db.query(CartsTable.tableName);

      final data = response.map((item) => CartProduct.fromJson(item)).toList();

      return data;
    } catch (error) {
      debugPrint("$_tag error in get carts products function ====> $error");
      return [];
    }
  }

  // update product quantity in cart
  static Future<int> updateProductQuantity(int productId, int quantity) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      return await db.update(
        CartsTable.tableName,
        {CartsTable.columnQuantity: quantity},
        where: '${CartsTable.columnProductId} = ?',
        whereArgs: [productId],
      );
    } catch (error) {
      debugPrint("$_tag error in update product quantity====> $error");
      return 0;
    }
  }

  // delete/remove a product from cart
  static Future<int> deleteProduct(int id) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      return await db.delete(
        CartsTable.tableName,
        where: '${CartsTable.columnProductId} = ?',
        whereArgs: [id],
      );
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return 0;
    }
  }

  // delete/remove a product from cart
  static Future<void> deleteProducts(List<CartProduct> cartData) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      for (var item in cartData) {
        await db.delete(
          CartsTable.tableName,
          where: '${CartsTable.columnProductId} = ?',
          whereArgs: [item.productItem.id],
        );
      }
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return ;
    }
  }

  static Future<bool> isPresentInCart(int productId) async {
    final db = await DbProvider.getDataBaseInstance();
    final result = await db.query(
      CartsTable.tableName,
      columns: [CartsTable.columnProductId],
      where: '${CartsTable.columnProductId} = ?',
      whereArgs: [productId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
