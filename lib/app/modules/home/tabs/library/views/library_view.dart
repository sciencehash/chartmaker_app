import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/directory/directory_card.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/directory/directory_list_tile.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/document/document_card.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/document/document_list_tile.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/widgets/top_bar.dart';
import 'package:chartmaker_app/app/modules/home/widgets/empty_list_msg.dart';
import 'package:chartmaker_app/app/widgets/view_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

class LibraryView extends StatelessWidget {
  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _libraryCtrl.currentLibrary.value == null
          ? ViewLoadingIndicator()
          : _libraryCtrl.dirs.isEmpty && _libraryCtrl.docs.isEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TopBar(),
                    Expanded(
                      child: EmptyListMsg(),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    TopBar(),
                    LibraryContent(),
                  ],
                ),
    );
  }
}

class LibraryContent extends StatelessWidget {
  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    bool isOddRow = false;

    bool _getIsOddRow() {
      isOddRow = !isOddRow;
      return !isOddRow;
    }

    return Obx(
      () => _libraryCtrl.currentLibrary.value!.viewMode == 'grid'
          ? Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 17, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      ..._libraryCtrl.dirs
                          .map(
                            (e) => DirectoryCard(
                                index: _libraryCtrl.dirs.indexOf(e)),
                          )
                          .toList(),
                      ..._libraryCtrl.docs
                          .map(
                            (e) => DocumentCard(
                                index: _libraryCtrl.docs.indexOf(e)),
                          )
                          .toList(),
                      SizedBox(height: 70),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              children: [
                ..._libraryCtrl.dirs
                    .map(
                      (e) => DirectoryListTile(
                        index: _libraryCtrl.dirs.indexOf(e),
                        isOdd: _getIsOddRow(),
                      ),
                    )
                    .toList(),
                ..._libraryCtrl.docs
                    .map(
                      (e) => DocumentListTile(
                        index: _libraryCtrl.docs.indexOf(e),
                        isOdd: _getIsOddRow(),
                      ),
                    )
                    .toList(),
                SizedBox(height: 70),
              ],
            ),
    );
  }
}
