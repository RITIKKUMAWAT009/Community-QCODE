import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/device_utility/device_utility.dart';
import 'package:community/core/utils/helper/helper_functions.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/on_boarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
      left: 200,
      bottom: DeviceUtils.getBottomNavigationBarHeight()*3,
      child: SizedBox(
        height: 20,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? Colors.white : Colors.black,
              dotHeight: 6),
        ),
      ),
    );
  }
}
