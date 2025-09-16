import 'package:apnidhukan/products_checkout/controller/checkout_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products_cart/modules/cart_product.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final arguments = Get.arguments;
    if (arguments != null) {
      List<CartProduct> cartsProducts = arguments['data'];
      if (cartsProducts.isNotEmpty) {
        controller.setCartsProducts(cartsProducts);
      }
    } else {
      Get.back();
    }
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                "Order Summary",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              /*
              bottom: PreferredSize(
                preferredSize: Size(Get.width, 56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),

                            child: Icon(
                              Icons.done,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color: theme.colorScheme.onPrimary,
                            ),

                            child: Text(
                              "2",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Text(
                            "Order Summary",
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),

                            child: Text(
                              "3",
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),

                          Text(
                            "Payment",
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              */
            ),

            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,

                children: [
                  const SizedBox(height: 4.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Delivery Address",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.payAndCheckOut();
                          },
                          child: Text("Change"),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Karanbir Singh",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "+91 9876543210",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Hno 182, phase 5, sector 59, Mohali, Punjab",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),

                  Divider(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "Shopping bag",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return cartProductItem(index, theme);
                }, childCount: controller.cartData.length),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0),
          ),

          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price : ",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          "₹  ${controller.totalPrice.value.toStringAsFixed(2)} ",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.info_circle,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: theme.colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    controller.payAndCheckOut();
                  },
                  child: Text("Pay now"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget cartProductItem(int index, ThemeData theme) {
    return Container(
      width: 84,
      margin: EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
      padding: EdgeInsets.all(4),

      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primaryContainer,
          width: 1.5,
        ),
      ),
      child: Obx(() {
        final cartItem = controller.cartData[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12.0,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    constraints: BoxConstraints(minHeight: 48),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.25,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                    ),
                    child: Image.network(
                      cartItem.productItem.images[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Flexible(
                  flex: 4,
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4.0,

                      children: [
                        Text(
                          cartItem.productItem.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "₹ ${controller.totalPrice.value.toStringAsFixed(2)}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),

                            const SizedBox(width: 16.0),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Qty: ${cartItem.quantity} ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),

                                DropdownMenu(
                                  maxLines: 1,
                                  enableSearch: false,
                                  menuHeight: 150,
                                  width: 48,
                                  inputDecorationTheme: InputDecorationTheme(
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),

                                  initialSelection: 1,
                                  onSelected: (value) {
                                    controller.updateQuantity(
                                      controller.cartData[index].productItem.id,
                                      value,
                                    );
                                  },

                                  dropdownMenuEntries: List.generate(10, (i) {
                                    return DropdownMenuEntry(
                                      value: i + 1,
                                      label: "${i + 1}",
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.0),
          ],
        );
      }),
    );
  }
}
