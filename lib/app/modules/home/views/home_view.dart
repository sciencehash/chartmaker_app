import 'package:flutter/material.dart';
import 'package:chartmaker_app/app/controllers/app_user_controller.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/views/library_view.dart';
import 'package:chartmaker_app/app/modules/home/widgets/app_bar.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Get.isRegistered<AppUserController>()
        ? HomeViewContent()
        : Container();
  }
}

class HomeViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          HomeAppBar(),
          SliverFillRemaining(
            child: LibraryView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //
        },
      ),
    );
  }
}
