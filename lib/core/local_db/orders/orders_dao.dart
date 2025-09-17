import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../../orders_history/modules/order_item.dart';
import '../db_provider.dart';
import 'orders_table.dart';

class OrdersDao {
  static final String _tag = "OredrsDao";

  /// Insert multiple orders
  static Future<int> insertOrderMultiple(List<OrderItem> orders) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      int count = 0;
      for (var order in orders) {
        await db.insert(
          OrdersTable.tableName,
          order.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        count++;
      }
      return count; // number of inserted rows
    } catch (error) {
      debugPrint("$_tag error in insertOrderMultiple ===== $error");
      return 0;
    }
  }

  /// Fetch all orders
  static Future<List<OrderItem>> getAllOrders() async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      final List<Map<String, dynamic>> maps = await db.query(
        OrdersTable.tableName,
        orderBy: "${OrdersTable.columnCreatedAt} DESC",
      );

      return maps.map((map) => OrderItem.fromJson(map)).toList();
    } catch (error) {
      debugPrint("$_tag error in get all orders list function ===== $error");
      return [];
    }
  }

  /// Fetch grouped by date (YYYY-MM-DD)
  static Future<Map<String, List<OrderItem>>> getOrdersGroupedByDate() async {
    try {
      // ORDER BY column name DESC


      final db = await DbProvider.getDataBaseInstance();

      final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT *, strftime('%Y-%m-%d', ${OrdersTable.columnCreatedAt}) as orderDate
      FROM ${OrdersTable.tableName}
      ORDER BY ${OrdersTable.columnCreatedAt} ASC
    ''');

      Map<String, List<OrderItem>> grouped = {};
      for (var row in result) {
        String date = row['orderDate'];
        grouped.putIfAbsent(date, () => []);
        grouped[date]!.add(OrderItem.fromJson(row));
      }
      return grouped;
    } catch (error) {
      debugPrint(
        "$_tag error in get orders history by group by function ===== $error",
      );
      return {};
    }
  }

  /// Delete single order by productId
  static Future<int> deleteOrder(int productId) async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      return await db.delete(
        OrdersTable.tableName,
        where: "${OrdersTable.columnProductId} = ?",
        whereArgs: [productId],
      );
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return 0;
    }
  }

  /// Clear all orders
  static Future<int> clearOrders() async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      return await db.delete(OrdersTable.tableName);
    } catch (error) {
      debugPrint("$_tag error in clearOrders function ===== $error");
      return 0;
    }
  }
}
