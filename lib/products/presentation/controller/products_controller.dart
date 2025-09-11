import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  List<Map<Icon, String>> categories = [
    {Icon(Icons.access_alarm): "Clock"},
    {Icon(Icons.phone_android): "Mobile"},
    {Icon(Icons.laptop): "Laptop"},
    {Icon(Icons.chair): "Furniture"},
    {Icon(Icons.watch): "Watch"},
    {Icon(Icons.book): "Books"},
    {Icon(Icons.headphones): "Headphones"},
  ];
}
