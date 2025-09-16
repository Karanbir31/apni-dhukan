import 'package:apnidhukan/payment/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentScreen extends GetView<PaymentController> {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/lottie/animation_done.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Obx(() => Text(
              "Redirecting in ${controller.countdown.value} sec...",
              style: theme.textTheme.titleMedium,
            )),
          ],
        ),
      ),
    );
  }
}
