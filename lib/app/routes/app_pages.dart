import 'package:get/get.dart';

import 'package:chartmaker_app/app/modules/account/bindings/account_binding.dart';
import 'package:chartmaker_app/app/modules/account/views/account_view.dart';
import 'package:chartmaker_app/app/modules/editor/bindings/editor_binding.dart';
import 'package:chartmaker_app/app/modules/editor/views/editor_view.dart';
import 'package:chartmaker_app/app/modules/home/bindings/home_binding.dart';
import 'package:chartmaker_app/app/modules/home/views/home_view.dart';
import 'package:chartmaker_app/app/modules/not_found/bindings/not_found_binding.dart';
import 'package:chartmaker_app/app/modules/not_found/views/not_found_view.dart';
import 'package:chartmaker_app/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:chartmaker_app/app/modules/notifications/views/notifications_view.dart';
import 'package:chartmaker_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:chartmaker_app/app/modules/profile/views/profile_view.dart';
import 'package:chartmaker_app/app/modules/search/bindings/search_binding.dart';
import 'package:chartmaker_app/app/modules/search/views/search_view.dart';
import 'package:chartmaker_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:chartmaker_app/app/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.EDITOR,
      page: () => EditorView(),
      binding: EditorBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.NOT_FOUND,
      page: () => NotFoundView(),
      binding: NotFoundBinding(),
    ),
  ];
}
