import 'package:apnidhukan/products_cart/controller/carts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartsScreen extends GetView<CartsController> {
  CartsScreen({super.key});

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    controller.readCartData();

    theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. top app bar with title and address
            SliverAppBar(
              floating: true,
              pinned: true,
              toolbarHeight: 56,
              expandedHeight: 90,
              backgroundColor: theme.colorScheme.primary,

              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 24,
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              bottom: PreferredSize(
                preferredSize: Size(Get.width, 56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: theme.colorScheme.onPrimary,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "Phase 5, sector 59, Mohali, Punjab",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return cartProductItem(index);
                }, childCount: controller.cart.length),
              ),
            ),

            SliverFillRemaining(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Table(
                    textBaseline: TextBaseline.ideographic,

                    border: TableBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      horizontalInside: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),
                      verticalInside: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),

                      top: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),

                      bottom: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),

                      left: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),
                      right: BorderSide(
                        style: BorderStyle.solid,
                        color: theme.colorScheme.surfaceTint.withValues(
                          alpha: 0.3,
                        ),
                        width: 1.5,
                      ),
                    ),

                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      // header row
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Product",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Qty",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "PP",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Price",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // dynamic rows
                      ...controller.cart.map(
                        (item) => cartSummaryRow(
                          title: item.productItem.title,
                          price: item.productItem.price,
                          quantity: item.quantity,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          color: theme.colorScheme.onPrimary
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          "₹  ${controller.totalPrice.value} ",
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary
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
                    controller.readCartData();
                  },
                  child: Text("Place Order"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget cartProductItem(int index) {
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
        final cartItem = controller.cart[index];
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
                            fontWeight:  FontWeight.bold
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
                                  onTap: () {
                                    controller.printData();
                                  },
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
                                      controller.cart[index].productItem.id,
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: const Divider(thickness: 1.2, color: Colors.grey),
            ),

            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  flex: 1,
                  child: buildButton(
                    text: "Remove",
                    onClickButton: () {
                      controller.removeFromCart(cartItem.productItem.id);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: buildButton(text: "Buy now", onClickButton: () {}),
                ),
              ],
            ),

            SizedBox(height: 4.0),
          ],
        );
      }),
    );
  }

  Widget buildButton({
    required String text,
    required void Function() onClickButton,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12.0),
          side: BorderSide(
            color: Colors.grey,
            width: 1.2,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onPressed: onClickButton,
      child: Text(text),
    );
  }

  TableRow cartSummaryRow({
    required String title,
    required double price,
    required int quantity,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: theme.textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            price.toStringAsFixed(2),
            style: theme.textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$quantity", style: theme.textTheme.titleMedium,),

        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (price * quantity).toStringAsFixed(2),
            style: theme.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
