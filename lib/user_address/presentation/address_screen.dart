import 'package:apnidhukan/user_address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: Text("Add new address")),

      body: Obx(() {
        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                onMapCreated: controller.onMapCreated,
                markers: controller.markers.toSet(),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: controller.currentLocation,
                  zoom: 48.0,
                ),

                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,

                // Remove zoom buttons
                zoomControlsEnabled: false,

                // Your existing gestures
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,

                onTap: (LatLng tappedLocation) {
                  controller.fetchPlaceFromLatLng(tappedLocation);
                },
              ),

              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox.shrink(),

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: _searchField(theme, context),
                ),
              ),
            ],
          ),
        );
      }),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.checkAndRequestLocationPermission();
        },
        label: Text("Use my current location"),
        icon: Icon(Icons.location_on_outlined),
      ),

      bottomNavigationBar: _buildBottomBar(theme),
    );
  }

  /// 🔍 Search field widget
  Widget _searchField(ThemeData theme, BuildContext context) {
    return SizedBox(
      height: 56,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller.searchTextController,
        googleAPIKey: "AIzaSyAvytL4YtoHhiMgfqF6P-AMIiPhGJbiXcs",
        inputDecoration: InputDecoration(
          hintText: "Search products...",
          hintStyle: TextStyle(color: theme.colorScheme.primary, fontSize: 16),

          prefixIcon: IconButton(
            onPressed: () async {},
            icon: Icon(Icons.search, color: theme.colorScheme.primary),
          ),

          suffixIcon: IconButton(
            onPressed: () {
              controller.searchTextController.text = "";
            },
            icon: Icon(Icons.clear, color: theme.colorScheme.primary),
          ),

          filled: true,
          fillColor: theme.colorScheme.onPrimary,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.onPrimary),
          ),
        ),
        debounceTime: 400,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          LatLng latLng = LatLng(
            double.parse(prediction.lat ?? "28.6139"),
            double.parse(prediction.lng ?? "77.2090"),
          );

          debugPrint("placeDetails Search place lat lng $latLng");

          controller.fetchPlaceFromLatLng(latLng);
        },

        itemClick: (Prediction prediction) {
          debugPrint("prediction selected $prediction");
        },

        seperatedBuilder: Divider(),

        itemBuilder: (context, index, Prediction prediction) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),

            color: theme.colorScheme.surface.withValues(alpha: 0.95),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8.0),
                  Expanded(child: Text(prediction.description ?? "")),
                ],
              ),
            ),
          );
        },

        isCrossBtnShown: false,

        // default 600 ms ,
      ),
    );
  }

  /// ---------------- BOTTOM BAR ----------------
  Widget _buildBottomBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Deliver to : ",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),

          Obx(
            () => Align(
              alignment: Alignment.center,
              child: controller.isLoading.value
                  ? _addressCardLoading(theme)
                  : _addressCard(theme),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  controller.showFilterBottomSheet();
                },
                child: Text("Add address details"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressCard(ThemeData theme) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.33),
            style: BorderStyle.solid,
          ),
        ),

        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 4.0,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.locality.value,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.fullAddress.value,
                  style: theme.textTheme.labelLarge?.copyWith(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressCardLoading(ThemeData theme) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.33),
            style: BorderStyle.solid,
          ),
        ),

        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 64,
            height: 64,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
