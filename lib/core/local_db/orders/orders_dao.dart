import 'package:sqflite/sqflite.dart';

import '../../../orders_history/modules/order_item.dart';
import 'orders_table.dart';

class OrdersDao {
  final Database db;

  OrdersDao(this.db);

  /// Insert an order
  Future<int> insertOrder(OrderItem order) async {
    return await db.insert(
      OrdersTable.tableName,
      order.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetch all orders
  Future<List<OrderItem>> getAllOrders() async {
    final List<Map<String, dynamic>> maps = await db.query(
      OrdersTable.tableName,
      orderBy: "${OrdersTable.columnCreatedAt} DESC",
    );

    return maps.map((map) => OrderItem.fromJson(map)).toList();
  }

  /// Fetch grouped by date (YYYY-MM-DD)
  Future<Map<String, List<OrderItem>>> getOrdersGroupedByDate() async {
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT *, strftime('%Y-%m-%d', ${OrdersTable.columnCreatedAt}) as orderDate
      FROM ${OrdersTable.tableName}
      ORDER BY ${OrdersTable.columnCreatedAt} DESC
    ''');

    Map<String, List<OrderItem>> grouped = {};
    for (var row in result) {
      String date = row['orderDate'];
      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(OrderItem.fromJson(row));
    }
    return grouped;
  }

  /// Delete single order by productId
  Future<int> deleteOrder(int productId) async {
    return await db.delete(
      OrdersTable.tableName,
      where: "${OrdersTable.columnProductId} = ?",
      whereArgs: [productId],
    );
  }

  /// Clear all orders
  Future<int> clearOrders() async {
    return await db.delete(OrdersTable.tableName);
  }
}
