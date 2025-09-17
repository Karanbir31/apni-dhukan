
import 'package:apnidhukan/payment/controller/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBindings extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> PaymentController());
  }

}