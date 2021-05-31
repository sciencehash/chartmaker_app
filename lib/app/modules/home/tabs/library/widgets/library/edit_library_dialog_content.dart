import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';
import 'package:chartmaker_app/app/widgets/dialog_scaffold.dart';

class EditLibraryDialogContent extends StatefulWidget {
  final Library library;

  EditLibraryDialogContent({
    Key? key,
    required this.library,
  }) : super(key: key);

  @override
  _EditLibraryDialogContentState createState() =>
      _EditLibraryDialogContentState();
}

class _EditLibraryDialogContentState extends State<EditLibraryDialogContent> {
  bool _disableCreateButton = true;
  late String _libraryName;

  String _problemMsg = '';
  bool _showDeleteConfirmation = false;

  @override
  void initState() {
    super.initState();

    _libraryName = widget.library.title.tr;
  }

  @override
  Widget build(BuildContext context) {
    return !_showDeleteConfirmation
        ? DialogScaffold(
            maxWidth: 470,
            title: 'Edit library'.tr,
            content: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Library name'.tr,
                  ),
                  initialValue: _libraryName,
                  onChanged: (val) {
                    _libraryName = val.trim();
                    if (_libraryName.isEmpty && !_disableCreateButton) {
                      setState(() => _disableCreateButton = true);
                    } else if (_libraryName.isNotEmpty &&
                        _disableCreateButton) {
                      setState(() => _disableCreateButton = false);
                    }
                  },
                  onFieldSubmitted: (val) {
                    val = val.trim();
                    Get.back(result: val.isNotEmpty ? val : null);
                  },
                ),
                if (_problemMsg.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _problemMsg,
                      style: TextStyle(
                        color: Colors.red,
                        height: 1.4,
                      ),
                    ),
                  ),
              ],
            ),
            buttons: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Tooltip(
                  message: 'Delete library'.tr,
                  child: ElevatedButton(
                    child: Icon(Icons.delete, size: 20),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 16,
                      ),
                      minimumSize: Size.zero,
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      if (widget.library.dirs.isNotEmpty ||
                          widget.library.docs.isNotEmpty) {
                        setState(() {
                          _problemMsg =
                              'This library cannot be removed because it is not empty.'
                                  .tr;
                        });
                      } else {
                        setState(() {
                          _showDeleteConfirmation = true;
                        });
                      }
                    },
                  ),
                ),
                Expanded(child: Container()),
                OutlinedButton(
                  child: Text('CANCEL'.tr),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 26,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  child: Text('SAVE'.tr),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 26,
                    ),
                  ),
                  onPressed: _disableCreateButton
                      ? null
                      : () {
                          Get.back(result: _libraryName);
                        },
                ),
              ],
            ),
          )
        : DialogScaffold(
            maxWidth: 470,
            title: 'Delete library'.tr,
            content: Text('Confirm that you want to delete this library.'.tr),
            buttons: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  child: Text('CANCEL'.tr),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 26,
                    ),
                  ),
                  onPressed: () {
                    // Get.back();
                    setState(() {
                      _showDeleteConfirmation = false;
                    });
                  },
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  child: Text('DELETE'.tr),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 26,
                    ),
                    primary: Colors.red,
                  ),
                  onPressed: () async {
                    Get.back();
                    final _libraryCtrl =
                        Get.find<LibraryController>(tag: 'library');

                    await _libraryCtrl.removeLibrary(widget.library.id);
                  },
                ),
              ],
            ),
          );
  }
}
