import 'package:apnidhukan/user_address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveAddressBottomSheet extends StatelessWidget {
  SaveAddressBottomSheet({super.key});

  final formKey = GlobalKey<FormState>();

  final controller = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            spacing: 16.0,
            children: [
              SizedBox.shrink(),

              Text(
                "Enter Details : ",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: _buildAddressCard(theme),
              ),

              _myTextField(theme, "Name", controller.nameTextController),

              _myTextField(theme, "Contact", controller.contactTextController),

              Align(
                alignment: Alignment.center,
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
                      if (formKey.currentState!.validate()) {
                        controller.saveNewAddress();
                      }
                    },
                    child: Text("Save address"),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔍 Search field widget
  Widget _myTextField(
    ThemeData theme,
    String label,
    TextEditingController textController,
  ) {
    return TextFormField(
      controller: textController,
      maxLines: 1,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.33),
          ),
        ),
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return "$label is required";
      },
    );
  }



  Widget _buildAddressCard(ThemeData theme) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.33),
          style: BorderStyle.solid,
        ),
      ),

      child: Padding(
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
    );
  }
}
