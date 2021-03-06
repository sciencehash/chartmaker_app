import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/data/models/library.dart';
import 'package:chartmaker_app/app/widgets/dialog_scaffold.dart';

class DeleteDocumentDialogContent extends StatelessWidget {
  final DocumentFile document;

  DeleteDocumentDialogContent({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 470,
      title: 'Delete document'.tr,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confirm that you want to delete this document:'.tr),
          SizedBox(height: 7),
          Text(
            document.title,
            style: TextStyle(height: 1.4, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'This action is not reversible.'.tr,
            style: TextStyle(height: 1.4, color: Colors.red),
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
            child: Text('DELETE'.tr),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 26,
              ),
              primary: Colors.red,
            ),
            onPressed: () async {
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }
}
