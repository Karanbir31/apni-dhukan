import 'package:apnidhukan/payment/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class PaymentScreen extends GetView<PaymentController> {
  final controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink()?? IconButton(onPressed: (){
          Get.back(result: "OK");
        }, icon: Icon(Icons.arrow_back)),

        title: Text("Payment Screen"),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),

      body: SafeArea(child: Lottie.asset(
        'assets/lottie/animation_done.json',
         width: 200,
        height: 200,
        fit: BoxFit.cover,
         animate: true,

      )),



    );
  }
}
