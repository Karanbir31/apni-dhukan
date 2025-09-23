import 'dart:convert';
import 'dart:core';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/local_db/address/address_table.dart';

class AddressItem {
  int? id;
  String name;
  String contact;
  String shortAddress;
  String fullAddress;
  LatLng latLng;
  bool isDefault;

  AddressItem({
    this.id,
    required this.name,
    required this.contact,
    required this.shortAddress,
    required this.fullAddress,
    required this.latLng,
    this.isDefault = false, // Initialize with a default value
  });

  factory AddressItem.fromJson(Map<String, dynamic> json) {
    final latLngMap = jsonDecode(json[AddressTable.columnLatLng]) as Map<String, dynamic>;
    return AddressItem(
      id: json[AddressTable.columnId] as int?,
      name: json[AddressTable.columnName] as String,
      contact: json[AddressTable.columnContact] as String,
      shortAddress: json[AddressTable.columnShortAddress] as String,
      fullAddress: json[AddressTable.columnFullAddress] as String,
      latLng: LatLng(
        (latLngMap['lat'] as num).toDouble(),
        (latLngMap['lng'] as num).toDouble(),
      ),
      isDefault: (json[AddressTable.columnIsDefault] as int) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) AddressTable.columnId: id,
      AddressTable.columnName: name,
      AddressTable.columnContact: contact,
      AddressTable.columnShortAddress: shortAddress,
      AddressTable.columnFullAddress: fullAddress,

      // Store as {"lat": xx, "lng": yy}
      AddressTable.columnLatLng: jsonEncode({
        "lat": latLng.latitude,
        "lng": latLng.longitude,
      }),

      AddressTable.columnIsDefault: isDefault ? 1 : 0,
    };
  }

  String toDisplayString() {
    final List<String> parts = [
      // name,
      // contact,
      shortAddress,
      fullAddress
    ];
    return parts.join(', ');
  }

  bool isAddressNull(){
    return id == null;
  }

  @override
  String toString() => toDisplayString();


}
