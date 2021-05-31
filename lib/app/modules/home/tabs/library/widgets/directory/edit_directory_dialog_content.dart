import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/widgets/dialog_scaffold.dart';

class EditDirectoryDialogContent extends StatefulWidget {
  final DocumentDirectory directory;

  EditDirectoryDialogContent({
    Key? key,
    required this.directory,
  }) : super(key: key);

  @override
  _EditDirectoryDialogContentState createState() =>
      _EditDirectoryDialogContentState();
}

class _EditDirectoryDialogContentState
    extends State<EditDirectoryDialogContent> {
  bool _disableCreateButton = true;
  late String _directoryName;

  @override
  void initState() {
    super.initState();

    _directoryName = widget.directory.title.tr;
  }

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 470,
      title: 'Edit folder'.tr,
      content: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Folder name'.tr,
        ),
        initialValue: widget.directory.title,
        onChanged: (val) {
          _directoryName = val.trim();
          if (_directoryName.isEmpty && !_disableCreateButton) {
            setState(() => _disableCreateButton = true);
          } else if (_directoryName.isNotEmpty && _disableCreateButton) {
            setState(() => _disableCreateButton = false);
          }
        },
        onFieldSubmitted: (val) {
          val = val.trim();
          Get.back(result: val.isNotEmpty ? val : null);
        },
      ),
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
                    Get.back(result: _directoryName);
                  },
          ),
        ],
      ),
    );
  }
}
