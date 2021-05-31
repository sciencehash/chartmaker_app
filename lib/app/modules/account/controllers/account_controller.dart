import 'dart:async';

import 'package:get/get.dart';
import 'package:chartmaker_app/app/controllers/auth_controller.dart';
import 'package:chartmaker_app/app/modules/account/repositories/account_repository.dart';
import 'package:chartmaker_app/app/modules/auth/widgets/progress_indicator_dialog_content.dart';

class AccountController extends GetxController {
  final AccountRepository _accountRepository = AccountRepository();

  var isSubmitting = false.obs;
  StreamSubscription? _isSubmittingSubscription;

  @override
  void onInit() async {
    _listenIsSubmitting();

    //
    await _accountRepository.initProviders();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _isSubmittingSubscription?.cancel();

    super.onClose();
  }

  void _listenIsSubmitting() {
    _isSubmittingSubscription = isSubmitting.listen((value) {
      if (value) {
        // Show form submitting progress indicator
        Get.dialog(
          ProgressIndicatorDialogContent(),
          barrierDismissible: false,
        );
      } else {
        // Hide form submitting progress indicator
        if (Get.isDialogOpen!) {
          Get.back(closeOverlays: true);
        }
      }
    });
  }

  Future<void> signInWithGoogle() async {
    final _authCtrl = Get.find<AuthController>();

    try {
      // Show progress indicator and disable controls
      isSubmitting.value = true;

      //
      await _authCtrl.signInWithGoogle();

      // Hide progress indicator and enable controls
      isSubmitting.value = false;
    } catch (error) {
      // Hide progress indicator and enable controls
      isSubmitting.value = false;

      //
      Get.snackbar(
        'auth.signInErrorTitle'.tr,
        'auth.signInError'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }
}
