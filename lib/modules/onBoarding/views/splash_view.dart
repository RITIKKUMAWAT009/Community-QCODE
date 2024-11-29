  import 'package:community/core/utils/constants/image_const.dart';
import 'package:community/modules/onBoarding/views/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(context, '/onBoarding');
      Get.off( OnBoardingScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white.withOpacity(1),
      body: Center(
        child:SvgPicture.asset(ImageConstant.appLogo),
      ),    
    );
  }
}
