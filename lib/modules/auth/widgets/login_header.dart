

import 'package:flutter/material.dart';

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
         Image(
          height: 150,
          color: Colors.blue,
          fit: BoxFit.fill,
          image: AssetImage(ImageConstant.appLogo),
        ),
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
