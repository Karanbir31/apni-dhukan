import 'package:apnidhukan/user_address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends GetView<AddressController> {
  AddressScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Address"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check_box))],
        ),

    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Widget _buildDefaultCheckbox() {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         value: _isDefault,
  //         onChanged: (bool? value) {
  //           setState(() {
  //             _isDefault = value ?? false;
  //           });
  //         },
  //       ),
  //       const Text('Set as default address'),
  //     ],
  //   );
  // }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      debugPrint('Address to be saved: ');
    }
  }
}

/*


SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.addressLine1Controller,
                labelText: 'Address Line 1',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter address line 1' : null,
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.addressLine2Controller,
                labelText: 'Address Line 2 (Optional)',
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.cityController,
                labelText: 'City',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a city' : null,
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.stateController,
                labelText: 'State/Province/Region',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a state or province' : null,
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.postalCodeController,
                labelText: 'ZIP/Postal Code',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a postal code' : null,
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: controller.countryController,
                labelText: 'Country',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a country' : null,
              ),
              const SizedBox(height: 24.0),
              // _buildDefaultCheckbox(),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
 */
