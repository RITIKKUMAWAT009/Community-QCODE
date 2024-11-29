
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/image_const.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_constant.dart';
import '../controller/signup/verify_email_controller.dart';


class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
 final String? email;

  @override
  Widget build(BuildContext context) {
    final emailVerificationController=Get.put(VerifyEmailController());
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          actionsIconTheme: Theme.of(context).iconTheme,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                //image
                Image(
                    width: HelperFunctions.screenWidth() * 0.8,
                    image:const  AssetImage(AnimationConstant.deliveredEmailIllustration)),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),

                //title
                Text(
                  TextConstant.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  email??'',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  TextConstant.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                //button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() =>emailVerificationController.checkEmailVerificationStatus(),transition: Transition.zoom,duration: const Duration(milliseconds: 600)),
                    child: const Text("Continue"),
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: ()=>emailVerificationController.sendEmailVerification(),
                    child: const Text(TextConstant.resendEmail),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
