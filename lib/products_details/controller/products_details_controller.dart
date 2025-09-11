import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDetailsController extends GetxController {
  RxInt cartCount = 0.obs;
  RxBool isFavorite = false.obs;

  void updateIsFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void updateDeliveryAddress() {
    showBottomSheet();
  }

  void myModelBottomSheet(BuildContext context){
    showModalBottomSheet(context: context, builder: (){

    })
  }

  void showBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      enableDrag: true,
      isDismissible: true,
      Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 12, backgroundColor: Colors.red,),

            title: Text("Title"),
            subtitle: Text("Sub Title"),

          ),

          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
