

import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/constants/image_const.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_constant.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40,),

         Center(
           child: Lottie.asset(
            height:HelperFunctions.screenHeight()*0.25,
           AnimationConstant.onBoardingAnim3,),
         ),
        
        SizedBox(height: 40,),
        Text(
          TextConstant.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: Sizes.sm,
        ),
        Text(
          TextConstant.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
