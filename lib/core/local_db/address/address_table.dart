class AddressTable {
  static const String tableName = 'addresses';

  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnContact = 'contact';
  static const String columnShortAddress = 'shortAddress';
  static const String columnFullAddress = 'fullAddress';
  static const String columnLatLng = 'latLng';
  static const String columnIsDefault = 'isDefault'; // New static constant

  // The create table query must also be updated
  static const String createTableQuery = '''
    CREATE TABLE ${AddressTable.tableName} (
      ${AddressTable.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AddressTable.columnName} TEXT NOT NULL,
      ${AddressTable.columnContact} TEXT NOT NULL,
      ${AddressTable.columnShortAddress} TEXT,
      ${AddressTable.columnFullAddress} TEXT NOT NULL,
      ${AddressTable.columnLatLng} TEXT NOT NULL,
      ${AddressTable.columnIsDefault} INTEGER NOT NULL DEFAULT 0
    )
  ''';
}
