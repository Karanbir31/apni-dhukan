import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSearchSliverBar extends StatelessWidget {
  TopSearchSliverBar({super.key});

  ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    theme = context.theme;
    return SliverAppBar(
      elevation: 8,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0)),
      ),
      clipBehavior: Clip.antiAlias,
      shadowColor: theme!.shadowColor,
      expandedHeight: 160,
      toolbarHeight: 64,
      floating: true,
      pinned: true,
      backgroundColor: theme!.colorScheme.primary.withValues(alpha: 1.0),
      foregroundColor: theme!.colorScheme.onPrimary,

      // Search bar at bottom
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 1,
                  cursorColor: theme!.colorScheme.primary,
                  style: TextStyle(
                    color: theme!.colorScheme.primary,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: TextStyle(
                      color: theme!.colorScheme.primary,
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.mic, color: theme!.colorScheme.primary),
                      onPressed: () {},
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: theme!.colorScheme.primary,
                      ),
                    ),
                    filled: true,
                    fillColor: theme!.colorScheme.onPrimary.withValues(
                      alpha: 1,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: theme!.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme!.colorScheme.primaryFixed.withValues(alpha: 0.40),
                theme!.colorScheme.primary.withValues(alpha: 0.80),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: myContainerWithIconAndText(
                        label: "Box 1",
                        backGroundColor: theme!.colorScheme.onPrimary
                            .withValues(alpha: 1.0),
                        icons: Icon(
                          Icons.add,
                          color: theme!.colorScheme.onPrimaryContainer,
                        ),
                        onClick: () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: myContainerWithIconAndText(
                        backGroundColor: theme!.colorScheme.onPrimary
                            .withValues(alpha: 0.5),
                        label: "Box 2",
                        icons: Icon(
                          Icons.add,
                          color: theme!.colorScheme.onPrimaryContainer,
                        ),
                        onClick: () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: myContainerWithIconAndText(
                        label: "Box 3",
                        backGroundColor: theme!.colorScheme.onPrimary
                            .withValues(alpha: 0.5),
                        icons: Icon(
                          Icons.add,
                          color: theme!.colorScheme.onPrimaryContainer,
                        ),
                        onClick: () {},
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: theme!.colorScheme.onPrimary,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Phase 5, sector 59, Mohali, Punjab",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme!.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: theme!.colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myContainerWithIconAndText({
    required String label,
    required Icon icons,
    required Color backGroundColor,
    required void Function() onClick,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: backGroundColor,
        border: Border.all(
          color: theme!.colorScheme.onPrimaryContainer,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icons,
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: theme!.colorScheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
