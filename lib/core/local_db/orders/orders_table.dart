class OrdersTable {
  static const String tableName = "user_order_history";
  static const String columnProductId = "id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  static const String columnCategory = "category";
  static const String columnPrice = "price";
  static const String columnDiscountPercentage = "discountPercentage";
  static const String columnRating = "rating";
  static const String columnImages = "images";
  static const String columnBrand = "brand";
  static const String columnQuantity = "quantity";
  static const String columnCreatedAt = "createdAt";

  static const String createTableQuery =
  '''
    CREATE TABLE $tableName(
      $columnProductId INTEGER PRIMARY KEY,
      $columnTitle TEXT,
      $columnDescription TEXT,
      $columnCategory TEXT,
      $columnPrice REAL,
      $columnDiscountPercentage REAL,
      $columnRating REAL,
      $columnImages TEXT,
      $columnBrand TEXT,
      $columnQuantity INTEGER,
      $columnCreatedAt TEXT
    )
  ''';
}
