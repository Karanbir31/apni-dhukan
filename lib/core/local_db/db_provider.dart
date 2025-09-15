import 'package:apnidhukan/products_cart/modules/cart_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final _tag = "dp_provider";

  DbProvider._singleton();

  static DbProvider instance = DbProvider._singleton();

  static Database? db;

  static const String tableName = "user_cart";

  static const String columnId = "id";
  static const String columnProductId = "product_id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  static const String columnCategory = "category";
  static const String columnPrice = "price";
  static const String columnDiscountPercentage = "discountPercentage";
  static const String columnRating = "rating";
  static const String columnImages = "images";
  static const String columnBrand = "brand";
  static const String columnQuantity = "quantity";

  static Future<Database> getDataBaseInstance() async {
    db ??= await _openDatabase();
    return db!;
  }

  static Future<Database> _openDatabase() async {
    final appDir = await getApplicationCacheDirectory();
    final dbPath = join(appDir.path, "user_cart.db");

    Database db = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnDescription TEXT,
        $columnCategory TEXT,
        $columnPrice REAL,
        $columnDiscountPercentage REAL,
        $columnRating REAL,
        $columnImages TEXT,
        $columnBrand TEXT,
        $columnQuantity INTEGER,        
      ''');
      },
    );

    return db;
  }

  Future<int> insertCartProduct(CartProduct product) async {
    try {
      if (db == null) {
        await getDataBaseInstance();
      }
      return await db!.insert(
        tableName,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      debugPrint("$_tag error in insert function ==== $error");
      return 0;
    }
  }

  Future<List<CartProduct>> getCartProducts() async {
    try {
      if (db == null) {
        await getDataBaseInstance();
      }

      final response = await db!.query(tableName);

      final data = response.map((item) => CartProduct.fromJson(item)).toList();

      return data;
    } catch (error) {
      debugPrint("$_tag error in get carts products function ====> $error");
      return [];
    }
  }

  Future<int> updateProductQuantity(CartProduct product) async {
    try {
      if (db == null) {
        await getDataBaseInstance();
      }

      return await db!.update(
        tableName,
        product.toJson(),
        where: '$columnId = ?',
        whereArgs: [product.productItem.id],
      );
    } catch (error) {
      debugPrint("$_tag error in update product quantity====> $error");
      return 0;
    }
  }

  Future<int> deleteProduct(int id) async {
    try {
      if (db == null) {
        await getDataBaseInstance();
      }
      return await db!.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );
    } catch (error) {
      debugPrint("$_tag error in delete product function ===== $error");
      return 0;
    }
  }
}
