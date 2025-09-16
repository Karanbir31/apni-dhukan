import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsFilterBottomSheet extends StatelessWidget {
  const ProductsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children: [
        ListTile(
          leading: CircleAvatar(radius: 16, backgroundColor: Colors.red,),
          title: Text("data"),
          subtitle: Text("data"),
          
        ),
        
        Text("Get x bottom sheet"),

        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("close"),
        ),
      ],
    );
  }
}
