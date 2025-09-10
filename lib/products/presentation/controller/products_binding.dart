import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:get/get.dart';

class ProductsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(()=> ProductsController());
  }



}