import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

import 'document_menu_button.dart';

class DocumentCard extends StatelessWidget {
  final int index;

  DocumentCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final _libraryCtrl = Get.find<LibraryController>(tag: 'library');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double? cardWidth = screenWidth <= 480
        ? null
        : (screenWidth <= 625 ? (screenWidth - 25) / 2 : 300);

    return SizedBox(
      width: cardWidth,
      child: Card(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 2480 / 3508,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red.withOpacity(.03),
                      ),
                      child: Center(
                        child: Text(
                          'PDF',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            _libraryCtrl.docs[index].title,
                          ),
                        ),
                      ),
                    ),
                    DocumentMenuButton(
                      document: _libraryCtrl.docs[index],
                    ),
                  ],
                ),
              ],
            ),
          ),
          onPressed: () {
            Get.toNamed(
              '/view/${_libraryCtrl.currentLibrary.value!.id}-${_libraryCtrl.docs[index].idLib}',
            );
          },
        ),
      ),
    );
  }
}
