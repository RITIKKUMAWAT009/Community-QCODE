import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/constants/text_constant.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/form_divider.dart';
import '../../../core/widgets/social_button.dart';
import '../widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                TextConstant.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              //form
             const SignUpForm(),
              //divider
              const SizedBox(height: Sizes.spaceBtwSections,),
              FormDivider(dividerText: TextConstant.orSignUpWith.capitalize!),
              //social button
              const SizedBox(height: Sizes.spaceBtwSections,),
             const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}

