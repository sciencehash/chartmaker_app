import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

class LibraryFabBottomSheetContent extends StatelessWidget {
  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 15),
        ListTile(
          leading: Icon(Icons.add_circle_outline, color: Colors.red),
          title: Text('Add local document'.tr),
          horizontalTitleGap: 0,
          onTap: () {
            Get.back();
            _libraryCtrl.addLocalFile();
          },
        ),
        ListTile(
          leading: Icon(Icons.add_to_drive, color: Colors.red),
          title: Text('Add document from Google Drive'.tr),
          horizontalTitleGap: 0,
          onTap: () async {
            Get.back();
            _libraryCtrl.addGoogleDriveFile();
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.saved_search, color: Colors.red),
        //   title: Text('Find all local documents'.tr),
        //   horizontalTitleGap: 0,
        //   onTap: () {
        //     Get.back();
        //   },
        // ),
        // ListTile(
        //   leading: Icon(Icons.playlist_add, color: Colors.red),
        //   title: Text('Add reading list'.tr),
        //   horizontalTitleGap: 0,
        //   onTap: () {
        //     Get.back();
        //   },
        // ),
        SizedBox(height: 15),
      ],
    );
  }
}
