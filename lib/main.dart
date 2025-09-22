import 'package:apnidhukan/core/app_const/my_app_theme.dart';
import 'package:apnidhukan/core/nav_routes/nav_pages.dart';
import 'package:apnidhukan/core/nav_routes/nav_routes.dart';
import 'package:apnidhukan/user_address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    final appTheme = MyAppTheme(textTheme);

    return GetMaterialApp(
      title: "Apni Dukan",

      onInit: () {
        // AddressDao.getAllAddresses();
        Get.put(AddressController(), permanent: true);
      },

      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(microseconds: 200),
      debugShowCheckedModeBanner: false,
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),

      initialRoute: NavRoutes.initialRoute,

      getPages: NavPages.pages,
    );
  }
}
