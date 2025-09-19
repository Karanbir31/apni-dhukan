class AddressTable {
  static const String tableName = 'addresses';

  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnAddressLine1 = 'addressLine1';
  static const String columnAddressLine2 = 'addressLine2';
  static const String columnCity = 'city';
  static const String columnState = 'state';
  static const String columnPostalCode = 'postalCode';
  static const String columnCountry = 'country';
  static const String columnIsDefault = 'isDefault'; // New static constant

  // The create table query must also be updated
  static const String createAddressTableQuery = '''
    CREATE TABLE ${AddressTable.tableName} (
      ${AddressTable.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AddressTable.columnName} TEXT NOT NULL,
      ${AddressTable.columnAddressLine1} TEXT NOT NULL,
      ${AddressTable.columnAddressLine2} TEXT,
      ${AddressTable.columnCity} TEXT NOT NULL,
      ${AddressTable.columnState} TEXT NOT NULL,
      ${AddressTable.columnPostalCode} TEXT NOT NULL,
      ${AddressTable.columnCountry} TEXT NOT NULL,
      ${AddressTable.columnIsDefault} INTEGER NOT NULL DEFAULT 0
    )
  ''';
}
