import 'package:apnidhukan/core/app_const/app_assets.dart';
import 'package:apnidhukan/products/presentation/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: productsScreenUi(context)));
  }

  Widget productsScreenUi(BuildContext context) {
    return CustomScrollView(
      slivers: [addressAppBar(context), searchBarAppBar(context)],
    );
  }

  Widget addressAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      elevation: 8,

      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              "Delivery Address",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Text(
              "Phase 5, sector 59, Mohali, Punjab",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          AppAssets.appLogo,
          fit: BoxFit.fill,

          width: 48,
          height: 48,
        ),
      ),
      actions: [
        IconButton(
          alignment: Alignment.center,

          onPressed: () {},
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              size: 32,
              Icons.notifications_none_outlined,
              color: context.theme.colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Widget searchBarAppBar(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Icon(Icons.search),
      elevation: 8,
      title: Text("Search here"),
      backgroundColor: Colors.grey,
    );
  }
}
