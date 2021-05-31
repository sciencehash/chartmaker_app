import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/widgets/dialog_scaffold.dart';

class EditDocumentDialogContent extends StatefulWidget {
  final DocumentFile document;

  EditDocumentDialogContent({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  _EditDocumentDialogContentState createState() =>
      _EditDocumentDialogContentState();
}

class _EditDocumentDialogContentState extends State<EditDocumentDialogContent> {
  bool _disableCreateButton = true;
  late String _documentName;

  @override
  void initState() {
    super.initState();

    _documentName = widget.document.title;
  }

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 470,
      title: 'Edit document'.tr,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Document name'.tr,
            ),
            initialValue: widget.document.title,
            onChanged: (val) {
              _documentName = val.trim();
              if (_documentName.isEmpty && !_disableCreateButton) {
                setState(() => _disableCreateButton = true);
              } else if (_documentName.isNotEmpty && _disableCreateButton) {
                setState(() => _disableCreateButton = false);
              }
            },
            onFieldSubmitted: (val) {
              val = val.trim();
              Get.back(result: val.isNotEmpty ? val : null);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'This does not change the name of the .pdf file, only the name of the document in this library.'
                  .tr,
              style: Get.theme.textTheme.caption!.copyWith(height: 1.4),
            ),
          ),
        ],
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
                    Get.back(result: _documentName);
                  },
          ),
        ],
      ),
    );
  }
}
