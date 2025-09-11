

import 'package:get/get.dart';

class MainScreenController extends GetxController{
  RxInt bottomNavSelectedIdx = 0.obs;

  void updateBottomNavSelectedIdx(int idx){
    bottomNavSelectedIdx.value = idx;
  }


}
