
import 'package:community/core/utils/constants/image_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/auth/controller/login/login_controller.dart';
import '../utils/constants/sizes.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final loginController=Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: ()=>loginController.googleSignIn(),
            icon:const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(ImageConstant.google),
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon:const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(ImageConstant.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
