import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/widgets/dialog_scaffold.dart';

class NewDirectoryDialogContent extends StatefulWidget {
  @override
  _NewDirectoryDialogContentState createState() =>
      _NewDirectoryDialogContentState();
}

class _NewDirectoryDialogContentState extends State<NewDirectoryDialogContent> {
  bool _disableCreateButton = true;
  String _directoryName = '';

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 470,
      title: 'New folder'.tr,
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Folder name'.tr,
        ),
        onChanged: (val) {
          _directoryName = val.trim();
          if (_directoryName.isEmpty && !_disableCreateButton) {
            setState(() => _disableCreateButton = true);
          } else if (_directoryName.isNotEmpty && _disableCreateButton) {
            setState(() => _disableCreateButton = false);
          }
        },
        onSubmitted: (val) {
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
            child: Text('CREATE'.tr),
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
