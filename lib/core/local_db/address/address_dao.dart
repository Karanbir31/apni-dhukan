import 'package:flutter/foundation.dart'; // Import for debugPrint
import 'package:sqflite/sqflite.dart';

import '../../../user_address/modules/address_item.dart';
import '../db_provider.dart';
import 'address_table.dart';

class AddressDao {
  static final String _tag = "AddressDao";

  static bool haveDefaultAddress = false;

  static final List<AddressItem> allAddress = [];

  /// Debug: Print schema and raw data of address table
  static Future<void> debugPrintTable() async {
    try {
      final db = await DbProvider.getDataBaseInstance();

      // 🔹 Print schema
      final schema = await db.rawQuery(
        "PRAGMA table_info(${AddressTable.tableName});",
      );
      debugPrint(
        "$_tag ===== ADDRESS TABLE SCHEMA (${AddressTable.tableName}) =====",
      );
      for (var column in schema) {
        debugPrint(column.toString());
      }

      // 🔹 Print all raw rows
      final rows = await db.rawQuery(
        "SELECT * FROM ${AddressTable.tableName};",
      );
      debugPrint("$_tag ===== RAW DATA (${AddressTable.tableName}) =====");
      if (rows.isEmpty) {
        debugPrint("$_tag (no rows found)");
      } else {
        for (var row in rows) {
          debugPrint(row.toString());
        }
      }
    } catch (error) {
      debugPrint("$_tag error in debugPrintTable ===== $error");
    }
  }

  /// Insert a single address
  static Future<int> insertAddress(AddressItem address) async {
    debugPrint("$_tag ===== insertAddress (${address.toString()}) =====");

    try {
      if (!haveDefaultAddress) {
        haveDefaultAddress = await _doesDatabaseHaveDefaultAddress();
        if (!haveDefaultAddress) {
          address = AddressItem(
            isDefault: true,
            name: address.name,
            contact: address.contact,
            shortAddress: address.shortAddress,
            fullAddress: address.fullAddress,
            latLng: address.latLng,
          );
        }
      }
    } catch (e) {
      debugPrint("$_tag error to set 1st default address error $e");
    }

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

      allAddress
        ..clear()
        ..addAll(maps.map((map) => AddressItem.fromJson(map)));

      return List.unmodifiable(allAddress);
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
    debugPrint("$_tag ===== getDefaultAddress =====");
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

  // Add this to your AddressDao class
  // ...
  static Future<bool> _doesDatabaseHaveDefaultAddress() async {
    debugPrint("$_tag ===== _doesDatabaseHaveDefaultAddress =====");
    try {
      final db = await DbProvider.getDataBaseInstance();
      final List<Map<String, dynamic>> maps = await db.query(
        AddressTable.tableName,
        where: "${AddressTable.columnIsDefault} = ?",
        whereArgs: [1],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return true;
      }
      return false;
    } catch (error) {
      debugPrint("$_tag error in _doesDatabaseHaveDefaultAddress ===== $error");
      return false;
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
