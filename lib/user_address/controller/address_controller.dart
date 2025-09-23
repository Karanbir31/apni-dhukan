import 'dart:convert';

import 'package:apnidhukan/core/local_db/address/address_dao.dart';
import 'package:apnidhukan/user_address/modules/address_item.dart';
import 'package:apnidhukan/user_address/presentation/address_bottom_sheets/save_address_bottom_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../core/app_utils/permission_utils.dart';

class AddressController extends GetxController {


  RxBool isLoading = true.obs;
  GoogleMapController? googleMapController;
  RxBool isLocationPermissionDenied = false.obs;
  RxBool isSearchBarVisible = true.obs;

  LatLng currentLocation = const LatLng(43.7333, 86.7794);

  final currentLocationMarkerId = MarkerId("current_location_marker_id");

  final RxSet<Marker> markers = <Marker>{}.obs;

  final TextEditingController searchTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController contactTextController = TextEditingController();

  RxString locality = "locality".obs;
  RxString fullAddress = "address".obs;

  ///=====================================================

  RxList<AddressItem> allAddresses = <AddressItem>[].obs;
  final localSearchController = TextEditingController();

  Future<void> getAllAddresses() async {
    allAddresses.clear();
    List<AddressItem> myList = await AddressDao.getAllAddresses();

    allAddresses.addAll(myList);
  }

  ///=====================================================

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // checkAndRequestLocationPermission();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkAndRequestLocationPermission();
  }

  void onMapCreated(GoogleMapController mapController) {
    googleMapController = mapController;
  }

  Future<void> saveNewAddress() async {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    isLoading.value = true;

    final newAddress = AddressItem(
      name: nameTextController.text,
      contact: contactTextController.text,
      shortAddress: locality.value,
      fullAddress: fullAddress.value,
      latLng: currentLocation,
    );

    await AddressDao.insertAddress(newAddress);

    // final productsController = Get.find<ProductsController>();
    // productsController.defaultAddress.value = newAddress;

    isLoading.value = false;
    Get.back();
  }

  Future<void> checkAndRequestLocationPermission() async {
    if (!await PermissionUtils.isLocationPermissionGranted()) {
      final result = await PermissionUtils.requestLocationPermission();
      if (result) {
        _fetchCurrentLocation();
      } else {
        isLocationPermissionDenied.value = true;
      }
    } else {
      _fetchCurrentLocation();
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      // Update LatLng
      currentLocation = LatLng(position.latitude, position.longitude);

      fetchPlaceFromLatLng(currentLocation);

      // Animate camera to current location
      googleMapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 16),
      );
    } catch (error) {
      debugPrint("Error accessing current location: $error");
    }
  }

  void addMarker(LatLng latLng, String place) {
    markers.clear();

    final marker = Marker(
      markerId: MarkerId(place),
      position: latLng,
      infoWindow: InfoWindow(title: place),
    );
    markers.add(marker);

    // Animate to selected place (NOT current location)
    googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));

    update(); // Notify GetBuilder (if you’re using it)
  }

  Future<void> fetchPlaceFromLatLng(LatLng latLng) async {
    currentLocation = latLng;
    isLoading.value = true;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$myApiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final result = data['results'][0];

          final formattedAddress = result['formatted_address'] ?? "";

          // Update search text or form fields
          searchTextController.text = formattedAddress;
          fullAddress.value = formattedAddress;

          // Optionally parse components
          for (var component in result['address_components']) {
            final types = component['types'] as List<dynamic>;
            if (types.contains('locality')) {
              //cityController.text = component['long_name'];
              locality.value = component['long_name'];
            }
          }

          // Add marker
          addMarker(latLng, formattedAddress);
        }
      } else {
        debugPrint("Geocoding API error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching place from LatLng: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      SaveAddressBottomSheet(),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,

      //backgroundColor: theme.colorScheme.surface,
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchTextController.dispose();
  }
}
