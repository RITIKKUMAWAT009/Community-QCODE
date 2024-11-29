import 'dart:async';


import 'package:community/core/utils/constants/text_constant.dart';
import 'package:community/core/utils/popups/loaders.dart';
import 'package:community/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //Send email whenever verify screen appears & Set Timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
  ///
  /// Automatically sends email verification link & sets timer for auto redirect
  ///
    super.onInit();
  }

  //Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

//Timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        //TODO:
        // Get.off(() => SuccessScreen(
        //     onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        //     image: 'assets/images/animations/72462-check-register.json',
        //     title: TextConstant.yourAccountCreatedTitle,
        //     subTitle: TextConstant.yourAccountCreatedSubTitle),transition: Transition.zoom,duration: const Duration(milliseconds: 1));
      }
    });
  }

//manually check if email verified

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      //TODO:
      
      // Get.off(() => SuccessScreen(
      //     onPressed: AuthenticationRepository.instance.screenRedirect(),
      //     image: 'assets/images/animations/72462-check-register.json',
      //     title: TextConstant.yourAccountCreatedTitle,
      //     subTitle: TextConstant.yourAccountCreatedSubTitle),transition: Transition.zoom,duration: const Duration(milliseconds: 600));
    }
  }
}
