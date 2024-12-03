
import 'package:community/core/utils/helper/network_connectivity.dart';
import 'package:community/core/utils/popups/full_screen_loader.dart';
import 'package:community/core/utils/popups/loaders.dart';
import 'package:community/data/models/user_model.dart';
import 'package:community/data/repositories/authentication/authentication_repository.dart';
import 'package:community/data/repositories/user/user_repository.dart';
import 'package:community/modules/auth/views/verify_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signUpForKey = GlobalKey<FormState>();

//signup
  Future<void> signup() async {
    try {
      //start loading
      print('opening loading dialog');
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
         return;
      }
      //form validation
      if (!signUpForKey.currentState!.validate()) {
         return;
      }
      //privacy policy check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must to read and accept the Privacy');
        return;
      }
      FullScreenLoader.openLoadingDialog(
          'We are processing your information....',
          'assets/animation/141594-animation-of-docer.json');
         //register user in firebase authentication and store data in firebase
      print('creating userCredential');
      final userCredential = await AuthenticationRepository.instance
          .registerUserWithEmailAndPassword(email.text, password.text);
      //save authenticated user data in the firestore
      print('Creating newUser');
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: "");
      print('userRepoInstance');
      //TODO:
      final userRepository=Get.put(UserRepository());
      print('saving user to db ');
  await  userRepository.saveUserRecord(newUser);
      //Show success message
      print('success snackbar');
Loaders.successSnackBar(title: 'Congratulations',message: 'Your account has been created');

//move to verify email screen
      print('go to veficationscrren');
      FullScreenLoader.stopLoading();

    Get.to(()=> VerifyEmailScreen(email: email.text.trim(),),transition: Transition.zoom,duration:const Duration(milliseconds: 600));
    } catch (e) {
      //show some generic errors to the user
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
//
}
