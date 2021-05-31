import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

class ChangeLibraryDialogContent extends StatelessWidget {
  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SimpleDialog(
        insetPadding: const EdgeInsets.all(10),
        titlePadding: const EdgeInsets.fromLTRB(23, 20, 10, 10),
        title: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 470,
            maxWidth: 470,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'Change library'.tr,
                        style: Get.theme.textTheme.headline6,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              Text(
                'Select a library from the list:'.tr,
                style: Get.theme.textTheme.bodyText1,
              ),
            ],
          ),
        ),
        children: _libraryCtrl.libraries.isEmpty
            ? [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                )
              ]
            : [
                ..._libraryCtrl.libraries
                    .map((library) => SimpleDialogOption(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_none,
                                size: 18,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  library.title.tr,
                                  style: TextStyle(height: 1.4),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.back(result: library.id);
                          },
                        ))
                    .toList(),
              ],
      ),
    );
  }
}
