import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

import 'directory_menu_button.dart';

class DirectoryListTile extends StatelessWidget {
  final int index;
  final bool isOdd;

  DirectoryListTile({
    Key? key,
    required this.index,
    this.isOdd = false,
  }) : super(key: key);

  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    final directory = _libraryCtrl.dirs[index];

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
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.withOpacity(.03),
          ),
          child: Center(
            child: Icon(Icons.folder_open),
          ),
        ),
      ),
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(directory.title),
      ),
      // subtitle: Text(directory.idLib.toString()),
      trailing: DirectoryMenuButton(
        directory: directory,
      ),
      onTap: () {
        _libraryCtrl.toDirectory(directory);
      },
    );
  }
}
