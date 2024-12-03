
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_constant.dart';
import '../../../core/utils/validators/validation.dart';
import '../controller/login/login_controller.dart';
import '../views/signup.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
        child: Column(
          children: [
            // const SizedBox(height: Sizes.spaceBtwInputFields,),

            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validator.validateEmail(value),
              decoration: InputDecoration(
                  label: Text(TextConstant.email,style: 
                Theme.of(context).textTheme.bodyMedium?.copyWith(color:HelperFunctions.isDarkMode(context)?Colors.white:Colors.black),
                  ),prefixIcon: const Icon(Iconsax.direct_right)),
            ),
            const SizedBox(
              height: Sizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                validator: (value) => Validator.validateEmptyText('Password',value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration( 
                  label: Text(TextConstant.password,style: 
                Theme.of(context).textTheme.bodyMedium?.copyWith(color:HelperFunctions.isDarkMode(context)?Colors.white:Colors.black),
                  ),
                    // labelText: TextConstant.password,
                    // labelStyle: Theme.of(context).textTheme.bodyMedium,
                  // labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color:HelperFunctions.isDarkMode(context)?Colors.white:Colors.black),

                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: controller.hidePassword.value?const Icon(Iconsax.eye_slash):const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () =>
                          controller.hidePassword.value =
                          !controller.hidePassword.value,
                    )),
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwInputFields / 2,
            ),

            // remember me & forgot pass
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      ()=> Checkbox(value: controller.isRemember.value, onChanged: (value) {
                        controller.isRemember.value= ! controller.isRemember.value;
                      }),
                    ),
                    const Text(TextConstant.rememberME),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  //  Get.to(() => const ForgotPassword(),transition: Transition.zoom,duration: const Duration(milliseconds: 600)),
                  child: const Text(TextConstant.forgotPassword),
                ),
              ],
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            //sign in button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  child: const Text(TextConstant.signIn),
                )),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: isDark
                      ? const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black))
                      : const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                  onPressed: () => Get.to(() => const SignUpScreen(),transition: Transition.zoom,duration: const Duration(milliseconds: 600)),
                  child: Text(
                    TextConstant.createAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
