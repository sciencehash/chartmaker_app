import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

enum _MenuOptions {
  selectAll,
  addLibrary,
  editLibrary,
  changeLibrary,
  goToTrash,
  goToArchive,
}

class TopBar extends StatelessWidget {
  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        bottom: Get.width > 620 ? 20 : 20,
        left: 17,
        right: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => Text(
                _libraryCtrl.dirLevels.isEmpty
                    ? _libraryCtrl.currentLibrary.value!.title.tr
                    : _libraryCtrl.dirLevels.last.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Obx(
            () => _libraryCtrl.dirLevels.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () {
                      _libraryCtrl.outsideDirectory();
                    },
                  )
                : Container(),
          ),
          IconButton(
            icon: Icon(Icons.create_new_folder_outlined),
            tooltip: 'Add folder'.tr,
            onPressed: () {
              _libraryCtrl.addDirectory();
            },
          ),
          IconButton(
            icon: Obx(
              () => _libraryCtrl.currentLibrary.value!.viewMode == 'grid'
                  ? Icon(Icons.grid_view)
                  : Icon(Icons.view_list),
            ),
            onPressed: () {
              _libraryCtrl.toggleViewMode();
            },
          ),
          PopupMenuButton<_MenuOptions>(
            onSelected: (_MenuOptions result) async {
              if (result == _MenuOptions.selectAll) {
                //
              } else if (result == _MenuOptions.addLibrary) {
                _libraryCtrl.addLibrary();
              } else if (result == _MenuOptions.editLibrary) {
                _libraryCtrl.editLibrary();
              } else if (result == _MenuOptions.changeLibrary) {
                _libraryCtrl.changeLibrary();
              } else if (result == _MenuOptions.goToTrash) {
                Get.toNamed('/trash');
              } else if (result == _MenuOptions.goToArchive) {
                Get.toNamed('/archive');
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<_MenuOptions>>[
              // PopupMenuItem<_MenuOptions>(
              //   value: _MenuOptions.selectAll,
              //   child: Row(
              //     children: [
              //       Icon(Icons.select_all),
              //       SizedBox(width: 10),
              //       Text('Select all'.tr),
              //     ],
              //   ),
              // ),
              PopupMenuItem<_MenuOptions>(
                value: _MenuOptions.addLibrary,
                child: Row(
                  children: [
                    Icon(Icons.library_add),
                    SizedBox(width: 10),
                    Text('Add library'.tr),
                  ],
                ),
              ),
              PopupMenuItem<_MenuOptions>(
                value: _MenuOptions.editLibrary,
                child: Row(
                  children: [
                    Icon(Icons.library_books),
                    SizedBox(width: 10),
                    Text('Edit library'.tr),
                  ],
                ),
              ),
              PopupMenuItem<_MenuOptions>(
                value: _MenuOptions.changeLibrary,
                child: Row(
                  children: [
                    Icon(Icons.amp_stories),
                    SizedBox(width: 10),
                    Text('Change library'.tr),
                  ],
                ),
              ),
              // PopupMenuDivider(),
              // PopupMenuItem<_MenuOptions>(
              //   value: _MenuOptions.goToArchive,
              //   child: Row(
              //     children: [
              //       Icon(Icons.archive),
              //       SizedBox(width: 10),
              //       Text('Archive'.tr),
              //     ],
              //   ),
              // ),
              // PopupMenuItem<_MenuOptions>(
              //   value: _MenuOptions.goToTrash,
              //   child: Row(
              //     children: [
              //       Icon(Icons.delete),
              //       SizedBox(width: 10),
              //       Text('Trash'.tr),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
