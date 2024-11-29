
import 'package:community/core/utils/constants/image_const.dart';
import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/constants/text_constant.dart';
import 'package:community/core/utils/device_utility/device_utility.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:community/core/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/styles/style.dart';
import '../controller/on_boarding_controller.dart';
import '../widgets/dot_navigation.dart';
import 'on_boarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});
String loremSummary = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat, nunc nec luctus aliquet, nunc nisl aliquet nisl,consectetur adipiscing elit. Donec consequat, nunc nec luctus aliquet, eget aliquet nisl nisl sit amet nisl.";
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OnBoardingController());

    return Scaffold(
      body:
      Stack(alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  [
               OnBoardingPage(
                    title: TextConstant.onBoarding1Title,
                    subTitle: loremSummary,
                    onBoardingImage: AnimationConstant.onBoardingAnim3,
                  ),
                  OnBoardingPage(
                    title: TextConstant.onBoarding2Title,
                    subTitle: loremSummary,
                    onBoardingImage:AnimationConstant.onBoardingAnim1,
                  ),
                  OnBoardingPage(
                    title: TextConstant.onBoarding3Title,
                    subTitle:loremSummary,
                    onBoardingImage: AnimationConstant.onBoardingAnim3,
                  ),
            ],
          ),
           //Dot navigation SmoothIndicator
           const OnBoardingDotNavigation(),
        
         Obx(
           ()=> Positioned(
            bottom: DeviceUtils.getBottomNavigationBarHeight(),
            child:controller.currentPageIndex.value==2?  SizedBox(
                width: HelperFunctions.screenWidth() * 0.9,
                height: HelperFunctions.screenHeight() / 18,
                child: ElevatedButton(onPressed:(){
                  controller.nextPage();
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child:  Text("Get Started",style: DefaultStyles.defaultTextStyleLight.copyWith(color: Colors.white),),),):
            CustomButtons.commonRowButton(button1Text:TextConstant.skip,onPressed1:controller.skipPage , onPressed2:controller.nextPage ,button2Text: TextConstant.next)),
         )
        

        ],
      ),
    );
  }
}


