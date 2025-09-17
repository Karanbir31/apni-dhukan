import 'package:apnidhukan/core/local_db/orders/orders_dao.dart';
import 'package:get/get.dart';

import '../modules/order_item.dart';

class OrdersHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxMap<String, List<OrderItem>> orderHistory = <String, List<OrderItem>>{}.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> getOrdersHistory() async {
    orderHistory.clear();
    final response = await OrdersDao.getOrdersGroupedByDate();

    orderHistory.addAll(response);
  }
}
