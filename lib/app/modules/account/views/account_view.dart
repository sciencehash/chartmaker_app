import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/controllers/app_user_controller.dart';
import 'package:chartmaker_app/app/modules/account/widgets/header.dart';
import 'package:chartmaker_app/app/widgets/view_loading_indicator.dart';

import '../controllers/account_controller.dart';

enum _LangMenuOptions {
  system,
  en,
  es,
}

class AccountView extends GetView<AccountController> {
  final _appUserCtrl = Get.find<AppUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/');
          },
        ),
        title: Text('Account settings'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Obx(
            () => _appUserCtrl.appUser.value == null
                ? ViewLoadingIndicator()
                : Column(
                    children: [
                      Divider(height: 2, thickness: 1),
                      Header(),
                      Divider(height: 2, thickness: 1),
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView(
                          children: [
                            ThemeListTile(),
                            LanguageListTile(),
                            if (_appUserCtrl.isLogged.value)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Divider(height: 2, thickness: 1),
                              ),
                            if (_appUserCtrl.isLogged.value)
                              ListTile(
                                title: Text('Plan: Premium FREE*'),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    r'*Free during beta, then 3 months free for being an Early adopter, then US $ 1.99 per month paying annually.'
                                        .tr,
                                    style: TextStyle(height: 1.4),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class LanguageListTile extends StatelessWidget {
  final _appUserCtrl = Get.find<AppUserController>();
  final langTitle =
      Get.locale.toString().startsWith('es') ? 'Español' : 'English';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Language'.tr),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          '${_appUserCtrl.appUser.value!.lang == 'sys' ? 'System language'.tr + ' (' + langTitle + ')' : langTitle}',
        ),
      ),
      trailing: PopupMenuButton<_LangMenuOptions>(
        onSelected: (_LangMenuOptions result) {
          if (result == _LangMenuOptions.system) {
            _appUserCtrl.changeLanguage('sys');
          } else if (result == _LangMenuOptions.en) {
            _appUserCtrl.changeLanguage('en');
          } else if (result == _LangMenuOptions.es) {
            _appUserCtrl.changeLanguage('es');
          }
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<_LangMenuOptions>>[
          PopupMenuItem<_LangMenuOptions>(
            value: _LangMenuOptions.system,
            child: Row(
              children: [
                Icon(Icons.arrow_right_rounded),
                SizedBox(width: 7),
                Text('System language'.tr),
              ],
            ),
          ),
          PopupMenuItem<_LangMenuOptions>(
            value: _LangMenuOptions.en,
            child: Row(
              children: [
                Icon(Icons.arrow_right_rounded),
                SizedBox(width: 7),
                Text('English'),
              ],
            ),
          ),
          PopupMenuItem<_LangMenuOptions>(
            value: _LangMenuOptions.es,
            child: Row(
              children: [
                Icon(Icons.arrow_right_rounded),
                SizedBox(width: 7),
                Text('Español'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeListTile extends StatelessWidget {
  final _appUserCtrl = Get.find<AppUserController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Theme'.tr),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          _appUserCtrl.appUser.value!.theme == 'sys'
              ? 'System theme'.tr
              : _appUserCtrl.appUser.value!.theme == 'light'
                  ? 'Light theme'.tr
                  : 'Dark theme'.tr,
        ),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 22,
          ),
        ),
        icon: Icon(
          _appUserCtrl.appUser.value!.theme == 'sys'
              ? Icons.brightness_4_rounded
              : _appUserCtrl.appUser.value!.theme == 'light'
                  ? Icons.brightness_7_rounded
                  : Icons.brightness_2_rounded,
        ),
        label: Text(
          _appUserCtrl.appUser.value!.theme == 'sys'
              ? 'System'.tr
              : _appUserCtrl.appUser.value!.theme == 'light'
                  ? 'Light'.tr
                  : 'Dark'.tr,
        ),
        onPressed: () {
          _appUserCtrl.toggleTheme();
        },
      ),
    );
  }
}
