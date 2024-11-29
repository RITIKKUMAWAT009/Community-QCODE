
import 'package:community/core/utils/constants/text_constant.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:community/core/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/constants/sizes.dart';
import '../controller/signup/signup_controller.dart';
import 'term_and_conditions.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final isDark = HelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signUpForKey,
      child: Column(
        children: [
          Row(
            children: [
              //first name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      Validator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TextConstant.firstName,
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: Sizes.spaceBtwInputFields,
              ),
              //lastname
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      Validator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TextConstant.lastName,
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputFields,
          ),
          //username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                Validator.validateEmptyText('User Name', value),
            decoration: InputDecoration(
                labelText: TextConstant.userName,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: const Icon(Iconsax.user)),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputFields,
          ),
          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: InputDecoration(
                labelText: TextConstant.email,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: const Icon(Icons.email_outlined)),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputFields,
          ),
          //phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: InputDecoration(
                labelText: TextConstant.phoneNo,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: const Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputFields,
          ),
          //password
          Obx(
                ()=>TextFormField(
              obscureText: controller.hidePassword.value,
              controller: controller.password,
              validator: (value) => Validator.validatePassword(value),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TextConstant.password,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  suffixIcon:  IconButton(icon:controller.hidePassword.value==true?const Icon(Iconsax.eye_slash):const Icon(Iconsax.eye),onPressed: (){controller.hidePassword.value= !controller.hidePassword.value;},)),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputFields,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value) {
                    controller.privacyPolicy.value=value!;
                  }))),
              const SizedBox(
                width: Sizes.spaceBtwItems,
              ),
              const TermAndConditions(),
            ],
          ),
          const SizedBox(
            height: Sizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                print("on signup click");
    controller.signup();
    },child: const Text(TextConstant.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
