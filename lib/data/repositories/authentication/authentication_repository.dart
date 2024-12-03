import 'dart:async';

import 'package:community/core/bindings/navigation_menu.dart';
import 'package:community/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:community/core/utils/exceptions/firebase_exceptions.dart';
import 'package:community/core/utils/exceptions/format_exceptions.dart';
import 'package:community/core/utils/exceptions/platform_exceptions.dart';
import 'package:community/core/utils/popups/full_screen_loader.dart';
import 'package:community/core/utils/theme/logging/logger.dart';
import 'package:community/modules/auth/views/login.dart';
import 'package:community/modules/auth/views/verify_email.dart';
import 'package:community/modules/onBoarding/views/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
 User? get authUser => _auth.currentUser;
//called from main.dart when app launch
  @override
  void onReady() {
    super.onReady();
    // FlutterNativeSplash.remove();
    RLoggerHelper.debug("onReady");
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
         Get.offAll(() => const NavigationExample(),transition: Transition.zoom,duration: const Duration(milliseconds: 600));
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ),transition: Transition.zoom,duration: const Duration(milliseconds: 600));
      }

    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen(),transition: Transition.zoom,duration: const Duration(milliseconds: 600))
          : Get.offAll(() =>  OnBoardingScreen(),transition: Transition.zoom,duration: const Duration(milliseconds: 600));
    }
  }

  ///[EmailAuthentication ]-SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  ///[GoogleAuthentication]-SignIn with google
  Future<UserCredential> loginWithGoogle() async {
    try {
//trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
// obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
//create new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
//return credential when user sing in
      return _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  ///[EmailAuthentication ]-Register
  Future<UserCredential> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

//mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
//send reset password email link
  Future<void>sendResetPasswordEmail(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }


  //logout user
  Future<void> logout() async {
    try {
      FullScreenLoader.openLoadingDialog('Please wait...Logging out...',
          "assets/animation/141594-animation-of-docer.json");
      Future.delayed(
        const Duration(seconds: 4),
        () async {
          await FirebaseAuth.instance.signOut();
          Get.offAll(() => const LoginScreen(),transition: Transition.zoom,duration:  const Duration(milliseconds: 600));
        },
      );
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
  //reAuthenticate User with email and password
  Future<void>reAuthenticateWithEmailAndPassword(String email,String password)async{
    try{
      //creating credential
      AuthCredential credential=EmailAuthProvider.credential(email: email, password: password);
      //reAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  //Delete account
  Future<void>deleteAccount()async{
    try{
      // await UserRepository.instance.deleteUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    }on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
