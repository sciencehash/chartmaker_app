import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chartmaker_app/app/modules/account/controllers/account_controller.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final _accountCtrl = Get.find<AccountController>(tag: 'account');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Container(
        width: 19,
        height: 19,
        margin: const EdgeInsets.only(right: 5),
        child: Image.asset('assets/images/social/google_logo.png'),
      ),
      label: Text('Sign in with Google'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 18,
        ),
      ),
      onPressed: () async {
        await _accountCtrl.signInWithGoogle();
      },
    );
  }
}
