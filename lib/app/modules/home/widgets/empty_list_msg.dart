import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyListMsg extends StatelessWidget {
  const EmptyListMsg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.inventory,
          size: 47,
          color: Get.isDarkMode ? Colors.white : Colors.black87,
        ),
        SizedBox(height: 15),
        Text(
          'Your document list is empty'.tr,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
