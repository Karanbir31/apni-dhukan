import 'package:apnidhukan/core/local_db/address/address_table.dart';
import 'package:apnidhukan/core/local_db/orders/orders_table.dart';
import 'package:apnidhukan/core/local_db/wishlist/wishlist_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'carts_table.dart';

class DbProvider {
  static final _tag = "dp_provider";

  DbProvider._singleton();

  static DbProvider instance = DbProvider._singleton();

  static Database? database;

  // get database instance
  static Future<Database> getDataBaseInstance() async {
    database ??= await _openDatabase();
    return database!;
  }

  // open existing database or create now database
  static Future<Database> _openDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, "user_cart.db");

    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(CartsTable.createTableQuery);
        await db.execute(WishlistTable.createTableQuery);
        await db.execute(OrdersTable.createTableQuery);
        await db.execute(AddressTable.createTableQuery);

      },
    );

    return db;
  }
}
