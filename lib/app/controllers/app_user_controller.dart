import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/core/utils/helpers/theme.dart';
import 'package:chartmaker_app/app/data/models/app_user.dart';
import 'package:chartmaker_app/app/data/repositories/app_user_repository.dart';

class AppUserController extends GetxController {
  static AppUserController to = Get.find();

  StreamSubscription? _authUserStateSubscription;

  final _appUserRepository = AppUserRepository();
  StreamSubscription? _appUserSubscription;

  Rxn<AppUser> appUser = Rxn<AppUser>();

  final isLogged = false.obs;

  // Migrating local data to remote
  bool isMigratingLocalDataToRemote = false;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    //
    final _authCtrl = AuthController.to;
    _authUserStateSubscription = _authCtrl.watchUserState.listen(
      _handleAuthStateChanges,
    );

    super.onReady();
  }

  @override
  void onClose() async {
    await _authUserStateSubscription?.cancel();
    await _appUserSubscription?.cancel();
    super.onClose();
  }

  // Handle changes between 'authenticated' and 'unauthenticated'
  Future<void> _handleAuthStateChanges(firebaseUser) async {
    // First of all, after an auth state change, close all subscriptions
    await _appUserSubscription?.cancel();

    //
    isLogged.value = firebaseUser != null;

    //
    await _appUserRepository.initProviders(
      isLocal: firebaseUser == null,
    );

    //
    _appUserSubscription?.cancel();
    //
    _appUserSubscription = _appUserRepository
        .watchById(isLogged.value ? firebaseUser!.uid : 'local')
        .listen(_handleAppUserChanges);
  }

  void _handleAppUserChanges(AppUser? newAppUser) async {
    //
    final _authCtrl = AuthController.to;

    // Create reader user if not exists
    if (newAppUser == null) {
      // Note: This runs locally the first time the user enters the app,
      // and remotely when the user signs up.

      // Create the reader user object
      AppUser _newUser = AppUser.minimum(
        id: isLogged.value ? _authCtrl.firebaseUser.value!.uid : 'local',
      );

      // Just to clarify: If the user has just sign up
      final bool _isNewRegisteredUser = isLogged.value;

      // If the user has just sign up
      if (_isNewRegisteredUser) {
        //
        isMigratingLocalDataToRemote = true;

        // Migrate local db collections to the remote db,
        // and get the local selectedLibraryId
        final _selectedLibraryId =
            await _appUserRepository.migrateLocalCollectionsToRemoteDb(
          _newUser.id,
        );

        // Set values from Firebase auth
        _newUser = _newUser.copyWith(
          email: _authCtrl.firebaseUser.value!.email,
          name: _authCtrl.firebaseUser.value!.displayName,
          photoUrl: _authCtrl.firebaseUser.value!.photoURL,
          selectedLibraryId: _selectedLibraryId,
        );
      }

      // Create the reader user in the db (local or remote)
      await _appUserRepository.add(_newUser);

      //
      isMigratingLocalDataToRemote = false;

      // Set value to the above code
      newAppUser = _newUser;
    }

    // If user change default language (including initial load)
    // Note: appUser.value = null on app init
    if (appUser.value == null || newAppUser.lang != appUser.value!.lang) {
      // At app init, this need a bit time
      if (appUser.value == null) {
        await Future.delayed(Duration(milliseconds: 200));
      }
      //
      if (newAppUser.lang == 'en' || newAppUser.lang == 'es') {
        Get.updateLocale(Locale(newAppUser.lang));
      } else {
        Get.updateLocale(Get.deviceLocale ?? Locale('en'));
      }
    }

    // If user select Dark mode (including initial load)
    // Note: appUser.value == null on app init
    if (appUser.value == null || newAppUser.theme != appUser.value!.theme) {
      if (newAppUser.theme == 'sys') {
        Get.changeThemeMode(ThemeMode.system);
      } else if (newAppUser.theme == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
      //
      bool? isDarkMode;
      // Wait after theme change
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        isDarkMode = Get.isDarkMode;
        //
        ThemeHelper.setSystemUIOverlayStyle(isDarkMode!);
      });

      // Wait after theme change
      // Repeat for slow devices
      Future.delayed(Duration(seconds: 5)).then((value) {
        if (isDarkMode != Get.isDarkMode) {
          //
          ThemeHelper.setSystemUIOverlayStyle(Get.isDarkMode);
        }
      });
    }

    // Set new value and refresh view
    appUser.value = newAppUser;
    appUser.refresh();
  }

  void toggleTheme() {
    late String newThemeName;

    if (appUser.value!.theme == 'sys')
      newThemeName = 'light';
    else if (appUser.value!.theme == 'light')
      newThemeName = 'dark';
    else if (appUser.value!.theme == 'dark') newThemeName = 'sys';

    _appUserRepository.update(
      appUser.value!.copyWith(
        theme: newThemeName,
      ),
    );
  }

  void changeLanguage(String key) {
    _appUserRepository.update(
      appUser.value!.copyWith(
        lang: key,
      ),
    );
  }

  Future<void> updateAppUser(AppUser appUser) async {
    await _appUserRepository.update(appUser);
  }
}
