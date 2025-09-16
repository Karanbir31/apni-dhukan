import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(vsync: this);

  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
    animationController.repeat(
      period: Duration(seconds: 3)
    );

  }
}
