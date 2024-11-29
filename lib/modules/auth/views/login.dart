import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/constants/text_constant.dart';
import 'package:community/core/utils/helper/helper_functions.dart';

import 'package:flutter/material.dart';
import '../../../core/widgets/form_divider.dart';
import '../../../core/widgets/social_button.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: Sizes.defaultSpace),
          child: Column(
            children: [
              //logo ,title,subTitle
            const  LoginHeader(),
              LoginForm(isDark: isDark),
              //divider
             const FormDivider(dividerText: TextConstant.orSignInWith,),
              const SizedBox(height: Sizes.spaceBtwSections,),
              //footer
             const SocialButton()
            ],
          ),
        ),
      ),
    );
  }
}





