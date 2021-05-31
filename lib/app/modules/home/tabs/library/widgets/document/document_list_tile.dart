import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

import 'document_menu_button.dart';

class DocumentListTile extends StatelessWidget {
  final int index;
  final bool isOdd;

  DocumentListTile({
    Key? key,
    required this.index,
    this.isOdd = false,
  }) : super(key: key);

  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(17, 7, 10, 7),
      tileColor: !isOdd
          ? (Get.isDarkMode ? Color(0xff333333) : Color(0xffeeeeee))
          : null,
      leading: AspectRatio(
        aspectRatio: 2480 / 3508,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
            color: Colors.red.withOpacity(.03),
          ),
          child: Center(
            child: Text(
              'PDF',
              style: TextStyle(
                color: Colors.red,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          _libraryCtrl.docs[index].title,
        ),
      ),
      trailing: DocumentMenuButton(
        document: _libraryCtrl.docs[index],
      ),
      onTap: () {
        Get.toNamed(
          '/view/${_libraryCtrl.currentLibrary.value!.id}-${_libraryCtrl.docs[index].idLib}',
        );
      },
    );
  }
}
