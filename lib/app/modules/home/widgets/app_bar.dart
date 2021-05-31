import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      toolbarHeight: 65,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Get.theme.dividerColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              RawMaterialButton(
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for courses',
                      prefixIconConstraints: BoxConstraints(minWidth: 60),
                      prefixIcon: Icon(Icons.search),
                      // contentPadding: const EdgeInsets.all(0),
                      suffixIconConstraints: BoxConstraints(minWidth: 110),
                      suffixIcon: Container(width: 110),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.toNamed('/search');
                },
              ),
              Positioned(
                right: 15,
                child: _SuffixIconButtons(),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: 80,
    );
  }
}

class _SuffixIconButtons extends StatelessWidget {
  _SuffixIconButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   icon: Icon(
        //     Icons.notifications_none,
        //     size: 26,
        //     color: Get.theme.appBarTheme.actionsIconTheme?.color,
        //   ),
        //   onPressed: () {
        //     _homeCtrl.removePrimaryFocus();
        //     Get.toNamed('/notifications');
        //   },
        // ),
        // SizedBox(width: 3),
        IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            size: 26,
            color: Get.theme.appBarTheme.actionsIconTheme?.color,
          ),
          onPressed: () {
            Get.toNamed('/account');
          },
        ),
      ],
    );
  }
}
