import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:community/core/widgets/aniamtion_widget.dart';
import 'package:flutter/material.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
        required this.title,
        required this.subTitle,
        required this.onBoardingImage});

  final String title;
  final String subTitle;
  final String onBoardingImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: Column(
        children: [
          SizedBox(height:Sizes.largeSpace_50,),

          AnimationLoaderWidget(animation: onBoardingImage,text: "",),
          SizedBox(height:Sizes.largeSpace_50,),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: HelperFunctions.isDarkMode(context) ? Colors.white : Colors.black,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
                   SizedBox(height:Sizes.largeSpace_50,),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: HelperFunctions.isDarkMode(context) ? Colors.white : Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}