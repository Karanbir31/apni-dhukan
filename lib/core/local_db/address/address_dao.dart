import 'package:flutter/foundation.dart'; // Import for debugPrint
import 'package:sqflite/sqflite.dart';

import '../../../user_address/modules/address_item.dart';
import '../db_provider.dart';
import 'address_table.dart';

class AddressDao {
  static final String _tag = "AddressDao";

  /// Insert a single address
  static Future<int> insertAddress(AddressItem address) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      final id = await db.insert(
        AddressTable.tableName,
        address.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id; // Returns the id of the newly inserted row
    } catch (error) {
      debugPrint("$_tag error in insertAddress ===== $error");
      return 0;
    }
  }

  /// Fetch all addresses
  static Future<List<AddressItem>> getAllAddresses() async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      final List<Map<String, dynamic>> maps = await db.query(
        AddressTable.tableName,
        orderBy:
            "${AddressTable.columnId} ASC", // Or use a relevant column for sorting
      );

      return maps.map((map) => AddressItem.fromJson(map)).toList();
    } catch (error) {
      debugPrint("$_tag error in getAllAddresses ===== $error");
      return [];
    }
  }

  /// Fetch a single address by ID
  static Future<AddressItem?> getAddressById(int id) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      final List<Map<String, dynamic>> maps = await db.query(
        AddressTable.tableName,
        where: "${AddressTable.columnId} = ?",
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return AddressItem.fromJson(maps.first);
      }
      return null;
    } catch (error) {
      debugPrint("$_tag error in getAddressById ===== $error");
      return null;
    }
  }

  /// Update an existing address
  static Future<int> updateAddress(AddressItem address) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      return await db.update(
        AddressTable.tableName,
        address.toJson(),
        where: "${AddressTable.columnId} = ?",
        whereArgs: [address.id],
      );
    } catch (error) {
      debugPrint("$_tag error in updateAddress ===== $error");
      return 0;
    }
  }

  // Add this to your AddressDao class
  // ...
  static Future<void> setDefaultAddress(int addressId) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      await db.transaction((txn) async {
        // First, clear any existing default address
        await txn.update(
          AddressTable.tableName,
          {AddressTable.columnIsDefault: 0},
          where: "${AddressTable.columnIsDefault} = ?",
          whereArgs: [1],
        );

        // Then, set the specified address as the new default
        await txn.update(
          AddressTable.tableName,
          {AddressTable.columnIsDefault: 1},
          where: "${AddressTable.columnId} = ?",
          whereArgs: [addressId],
        );
      });
    } catch (error) {
      debugPrint("$_tag error in setDefaultAddress ===== $error");
    }
  }

  // Add this to your AddressDao class
  // ...
  static Future<AddressItem?> getDefaultAddress() async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      final List<Map<String, dynamic>> maps = await db.query(
        AddressTable.tableName,
        where: "${AddressTable.columnIsDefault} = ?",
        whereArgs: [1],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return AddressItem.fromJson(maps.first);
      }
      return null;
    } catch (error) {
      debugPrint("$_tag error in getDefaultAddress ===== $error");
      return null;
    }
  }

  /// Delete a single address by ID
  static Future<int> deleteAddress(int id) async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      return await db.delete(
        AddressTable.tableName,
        where: "${AddressTable.columnId} = ?",
        whereArgs: [id],
      );
    } catch (error) {
      debugPrint("$_tag error in deleteAddress ===== $error");
      return 0;
    }
  }

  /// Clear all addresses
  static Future<int> clearAddresses() async {
    try {
      final db = await DbProvider.getDataBaseInstance();
      return await db.delete(AddressTable.tableName);
    } catch (error) {
      debugPrint("$_tag error in clearAddresses ===== $error");
      return 0;
    }
  }
}
