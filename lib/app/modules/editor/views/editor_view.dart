import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/editor_controller.dart';

class EditorView extends GetView<EditorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditorView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
