import 'package:apnidhukan/orders_history/controller/orders_history_controller.dart';
import 'package:get/get.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersHistoryController());
  }
}
