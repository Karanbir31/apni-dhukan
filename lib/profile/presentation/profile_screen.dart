import 'package:apnidhukan/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: theme.colorScheme.primary,
              floating: true,

              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 12.0,

                        children: [
                          Text(
                            "Karanbir Singh",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            "Karanbir@test.com",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),

                      CircleAvatar(
                        backgroundColor: theme.colorScheme.onPrimary,
                        radius: 32.0,
                        // child: Image.network(
                        //   "",
                        //   alignment: AlignmentGeometry.center,
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Details : ",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,

                      child: basicInfoItemRow("Name ", "Karanbir Singh"),
                    ),

                    Divider(
                      height: 2,
                      color: theme.colorScheme.primaryContainer,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,

                      child: basicInfoItemRow("Contact ", "+91 9876543210"),
                    ),

                    Divider(
                      height: 2,
                      color: theme.colorScheme.primaryContainer,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,

                      child: basicInfoItemRow("Email ", "Karanbir@test.com"),
                    ),

                    Divider(
                      height: 2,
                      color: theme.colorScheme.primaryContainer,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                        shape: BoxShape.rectangle,
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,

                      child: basicInfoItemRow("Label ", "Value"),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: buildInfoContainer("Address", Icons.home),
            ),
            SliverToBoxAdapter(
              child: buildInfoContainer("Wallet", Icons.wallet),
            ),

            SliverToBoxAdapter(
              child: buildInfoContainer("Cart", Icons.shopping_cart),
            ),

            SliverToBoxAdapter(
              child: buildInfoContainer("Orders", Icons.shopping_basket),
            ),
            SliverToBoxAdapter(
              child: buildInfoContainer(
                "Help Center",
                Icons.headset_mic_rounded,
              ),
            ),

            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: SizedBox(width: Get.width * 0.33),
            ),
          ],
        ),
      ),
    );
  }

  Widget basicInfoItemRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: theme.textTheme.titleMedium,
          ),
        ),

        VerticalDivider(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.5,
          thickness: 1.5,
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoContainer(String label, IconData iconData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      margin: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.surfaceTint.withValues(alpha: 0.3),
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData),
          const SizedBox(width: 16.0),
          Expanded(flex: 1, child: Text(label)),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
