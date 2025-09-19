import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  // Private and final TextEditingControllers, initialized immediately.

  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
  }

}
