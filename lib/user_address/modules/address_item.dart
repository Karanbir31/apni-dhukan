import 'dart:core';

import '../../core/local_db/address/address_table.dart';

class AddressItem {
  int? id;
  String name;
  String addressLine1;
  String? addressLine2;
  String city;
  String state;
  String postalCode;
  String country;
  bool isDefault;

  AddressItem({
    this.id,
    required this.name,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false, // Initialize with a default value
  });

  // Factory constructor to create an AddressItem from a JSON map (deserialization)
  factory AddressItem.fromJson(Map<String, dynamic> json) {
    return AddressItem(
      id: json[AddressTable.columnId] as int?,
      name: json[AddressTable.columnName] as String,
      addressLine1: json[AddressTable.columnAddressLine1] as String,
      addressLine2: json[AddressTable.columnAddressLine2] as String?,
      city: json[AddressTable.columnCity] as String,
      state: json[AddressTable.columnState] as String,
      postalCode: json[AddressTable.columnPostalCode] as String,
      country: json[AddressTable.columnCountry] as String,
      isDefault: (json[AddressTable.columnIsDefault] as int) == 1,
    );
  }

  // Method to convert an AddressItem to a JSON map (serialization)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) AddressTable.columnId: id,
      AddressTable.columnAddressLine1: addressLine1,
      AddressTable.columnName: name,
      AddressTable.columnAddressLine2: addressLine2,
      AddressTable.columnCity: city,
      AddressTable.columnState: state,
      AddressTable.columnPostalCode: postalCode,
      AddressTable.columnCountry: country,
      AddressTable.columnIsDefault: isDefault ? 1 : 0,
    };
  }

  String toDisplayString() {
    final List<String> parts = [
      name,
      addressLine1,
      if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2!,
      city,
      '$state $postalCode',
      country,
    ];
    return parts.join(', ');
  }

  @override
  String toString() => toDisplayString();
}
