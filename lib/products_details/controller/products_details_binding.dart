
import 'package:apnidhukan/products_details/controller/products_details_controller.dart';
import 'package:get/get.dart';

class ProductsDetailsBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> ProductsDetailsController());
  }
}