

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProfileController extends GetxController{
  List<ProfileOtherDetails> profileOtherDetails = [
    ProfileOtherDetails(text: "Address", iconData: Icons.home),
    ProfileOtherDetails(text: "Wallet", iconData: Icons.wallet),
    ProfileOtherDetails(text: "Cart", iconData: Icons.shopping_cart),
    ProfileOtherDetails(text: "Orders", iconData: Icons.home),

  ];

}

class ProfileOtherDetails{
  String text;
  IconData iconData;

  ProfileOtherDetails({required this.text, required this.iconData});

}