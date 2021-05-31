import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/controllers/app_user_controller.dart';
import 'package:chartmaker_app/app/modules/account/widgets/avatar.dart';
import 'package:chartmaker_app/app/modules/account/widgets/sign_in_with_google_button.dart';

class Header extends StatelessWidget {
  final _appUserCtrl = Get.find<AppUserController>();
  final _authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => _appUserCtrl.appUser.value!.photoUrl != null
                ? Avatar(_appUserCtrl.appUser.value!)
                : Icon(Icons.account_circle_outlined, size: 57),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Obx(
                    () => Text(
                      _authCtrl.firebaseUser.value?.uid == null
                          ? 'Please sign in to get more features'.tr
                          : '${_appUserCtrl.appUser.value!.name} - ${_appUserCtrl.appUser.value!.email}',
                      style: TextStyle(height: 1.4),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Obx(
                  () => _authCtrl.firebaseUser.value?.uid == null
                      ? Row(
                          children: [
                            TextButton(
                              child: Text('Sign in'.tr),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(
                                  15,
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                            ),
                            Text(' | '),
                            TextButton(
                              child: Text('Sign up'.tr),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(
                                  15,
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/signup');
                              },
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            // TextButton(
                            //   child: Text('Edit your profile'.tr),
                            //   style: TextButton.styleFrom(
                            //     padding: const EdgeInsets.all(
                            //       15,
                            //     ),
                            //   ),
                            //   onPressed: () {
                            //     Get.toNamed('/profile');
                            //   },
                            // ),
                            // Text(' | '),
                            TextButton(
                              child: Text('Sign out'.tr),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(
                                  15,
                                ),
                              ),
                              onPressed: () async {
                                await _authCtrl.signOut();
                              },
                            ),
                          ],
                        ),
                ),
                Obx(
                  () => _authCtrl.firebaseUser.value?.uid == null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 7, top: 15),
                          child: SignInWithGoogleButton(),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
