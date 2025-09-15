

import 'package:get/get.dart';

class MainScreenController extends GetxController{
  RxInt bottomNavSelectedIdx = 0.obs;

  final cartsScreenIdx = 1;

  void navigate(int idx){
    bottomNavSelectedIdx.value = idx;
  }


}
