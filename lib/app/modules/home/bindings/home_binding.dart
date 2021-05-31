import 'package:get/get.dart';

import 'package:chartmaker_app/app/modules/home/controllers/home_controller.dart';
import 'package:chartmaker_app/app/modules/home/tabs/library/controllers/library_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      tag: 'home',
    );
    Get.lazyPut<LibraryController>(
      () => LibraryController(),
      tag: 'library',
    );
  }
}
