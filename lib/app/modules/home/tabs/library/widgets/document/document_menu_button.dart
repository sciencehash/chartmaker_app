import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

enum _MenuOptions {
  // move,
  // moveToTrash,
  // moveToArchive,
  // viewDbData,
  rename,
  // properties,
  remove,
}

class DocumentMenuButton extends StatelessWidget {
  final DocumentFile document;

  DocumentMenuButton({
    Key? key,
    required this.document,
  }) : super(key: key);

  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (_MenuOptions result) {
        if (result == _MenuOptions.rename) {
          //
          _libraryCtrl.renameDocument(document);
        } else if (result == _MenuOptions.remove) {
          //
          _libraryCtrl.deleteDocument(document);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
        // PopupMenuItem<_MenuOptions>(
        //   value: _MenuOptions.move,
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_right_rounded),
        //       SizedBox(width: 7),
        //       Text('Move'),
        //     ],
        //   ),
        // ),
        // PopupMenuItem<_MenuOptions>(
        //   value: _MenuOptions.moveToTrash,
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_right_rounded),
        //       SizedBox(width: 7),
        //       Text('Move to Trash'),
        //     ],
        //   ),
        // ),
        // PopupMenuItem<_MenuOptions>(
        //   value: _MenuOptions.moveToArchive,
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_right_rounded),
        //       SizedBox(width: 7),
        //       Text('Move to Archive'),
        //     ],
        //   ),
        // ),
        // PopupMenuItem<_MenuOptions>(
        //   value: _MenuOptions.viewDbData,
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_right_rounded),
        //       SizedBox(width: 7),
        //       Text('View data'),
        //     ],
        //   ),
        // ),
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.rename,
          child: Row(
            children: [
              Icon(Icons.drive_file_rename_outline),
              SizedBox(width: 7),
              Text('Rename'.tr),
            ],
          ),
        ),
        // PopupMenuItem<_MenuOptions>(
        //   value: _MenuOptions.properties,
        //   child: Row(
        //     children: [
        //       Icon(Icons.article_outlined),
        //       SizedBox(width: 7),
        //       Text('Properties'.tr),
        //     ],
        //   ),
        // ),
        PopupMenuDivider(),
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.remove,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 7),
              Text(
                'Delete document'.tr,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
