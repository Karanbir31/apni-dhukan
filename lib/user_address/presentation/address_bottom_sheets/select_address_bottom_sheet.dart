import 'package:apnidhukan/user_address/modules/address_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAddressBottomSheet extends StatelessWidget {
  SelectAddressBottomSheet({super.key});

  final searchTextController = TextEditingController();

  // Address 1: Karanbir Singh, phase 5, Mohali Punjab
  final testAddress1 = AddressItem(
    name: 'Karanbir Singh',
    addressLine1: 'Phase 5',
    city: 'Mohali',
    state: 'Punjab',
    postalCode: '160055',
    // Example postal code
    country: 'India',
  );

  // Address 2: Karanbir singh, phase 1, Amritsar punjab
  final testAddress2 = AddressItem(
    name: 'Karanbir Singh',
    addressLine1: 'Phase 1',
    city: 'Amritsar',
    state: 'Punjab',
    postalCode: '143001',
    // Example postal code
    country: 'India',
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          spacing: 16.0,
          children: [
            SizedBox.shrink(),

            Text(
              "Select delivery address",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            _searchField(theme, context),

            _useCurrentLocationRow(theme),

            // Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
            _selectionRow(theme),

            _buildAddressCard(testAddress1, true, theme),
            _buildAddressCard(testAddress2, false, theme),

            SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  /// 🔍 Search field widget
  Widget _searchField(ThemeData theme, BuildContext context) {
    return TextField(
      controller: searchTextController,
      maxLines: 1,
      readOnly: false,
      cursorColor: theme.colorScheme.primary,
      style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
      decoration: InputDecoration(
        hintText: "Search products...",
        hintStyle: TextStyle(color: theme.colorScheme.primary, fontSize: 16),

        prefixIcon: IconButton(
          onPressed: () async {},
          icon: Icon(Icons.search, color: theme.colorScheme.primary),
        ),
        filled: true,
        fillColor: theme.colorScheme.onPrimary,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget _useCurrentLocationRow(ThemeData theme) {
    return Card(
      elevation: 0,
      // subtle shadow
      margin: const EdgeInsets.symmetric(horizontal: 0.0),
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(12),
        //side: BorderSide(color: theme.colorScheme.primary, width: 1.8),
      ),
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(width: 8.0),

              Flexible(
                flex: 1,
                child: Text(
                  "Use my current location",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectionRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Text("Saved addresses", style: theme.textTheme.titleMedium),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {},
          child: Text("Add New"),
        ),
      ],
    );
  }

  Widget _buildAddressCard(
    AddressItem address,
    bool isSelected,
    ThemeData theme,
  ) {
    return Card(
      elevation: 3,
      // subtle shadow
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            spacing: 8.0,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                spacing: 12.0,
                children: [
                  Icon(CupertinoIcons.home),

                  Expanded(
                    flex: 1,
                    child: Wrap(
                      children: [
                        Text(
                          address.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        isSelected
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Icon(
                                  Icons.verified,
                                  color: theme.colorScheme.primary,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ],
              ),

              Text(address.toString(), style: theme.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
