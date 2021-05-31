import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

enum _MenuOptions {
  rename,
  remove,
}

class DirectoryMenuButton extends StatelessWidget {
  final DocumentDirectory directory;

  DirectoryMenuButton({
    Key? key,
    required this.directory,
  }) : super(key: key);

  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (_MenuOptions result) async {
        if (result == _MenuOptions.rename) {
          //
          _libraryCtrl.renameDirectory(directory);
        } else if (result == _MenuOptions.remove) {
          //
          _libraryCtrl.deleteDirectory(directory);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
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
        PopupMenuDivider(),
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.remove,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 7),
              Text(
                'Delete folder'.tr,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
