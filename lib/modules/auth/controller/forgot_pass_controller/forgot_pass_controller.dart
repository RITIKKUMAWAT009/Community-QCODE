
import 'package:community/core/utils/helper/network_connectivity.dart';
import 'package:community/core/utils/popups/loaders.dart';
import 'package:community/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/popups/full_screen_loader.dart';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance=>Get.find();

  final emailController=TextEditingController();

  final GlobalKey<FormState> forgotPassFromKey=GlobalKey<FormState>();

  //send reset password email
sendResetPasswordEmail()async{
  try{
    FullScreenLoader.openLoadingDialog('We are processing your request', 'assets/animation/141594-animation-of-docer.json');
    final bool isConnected=await NetworkManager.instance.isConnected();
    if(!isConnected){
      FullScreenLoader.stopLoading();
      return;
    }
    if(!forgotPassFromKey.currentState!.validate()){
      FullScreenLoader.stopLoading();
      return;
    }
    await AuthenticationRepository.instance.sendResetPasswordEmail(emailController.text.trim());
    //stop loader
    FullScreenLoader.stopLoading();
    //show success message
    Loaders.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password'.tr);
    // Get.to(()=>ResetPassword(email: emailController.text.trim(),),transition: Transition.zoom,duration: const Duration(milliseconds: 600));
  }catch(e){
FullScreenLoader.stopLoading();
Loaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
  }
}

resendResetPasswordEmail(String email)async{
  try{
    FullScreenLoader.openLoadingDialog('We are processing your request', 'assets/animation/141594-animation-of-docer.json');
    final bool isConnected=await NetworkManager.instance.isConnected();
    if(!isConnected){
      FullScreenLoader.stopLoading();
      return;
    }

    await AuthenticationRepository.instance.sendResetPasswordEmail(email);
    //stop loader
    FullScreenLoader.stopLoading();
    //show success message
    Loaders.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password'.tr);
    }catch(e){
    FullScreenLoader.stopLoading();
    Loaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
  }
}
}