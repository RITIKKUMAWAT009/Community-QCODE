import 'package:community/core/utils/constants/sizes.dart';
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:community/core/utils/styles/style.dart';
import 'package:flutter/material.dart';

class CustomButtons{


  static Widget commonRowButton({ String button1Text = "", String button2Text = "", required VoidCallback onPressed1, required VoidCallback onPressed2}){
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: HelperFunctions.screenWidth() / 2.3,
              height: HelperFunctions.screenHeight() / 18,
              child: ElevatedButton(onPressed: onPressed1, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child:  Text(button1Text,style: DefaultStyles.defaultTextStyleLight.copyWith(color: Colors.white,),))),
          SizedBox(width: Sizes.defaultSpace,),
          SizedBox(
              width: HelperFunctions.screenWidth() / 2.3,
              height: HelperFunctions.screenHeight() / 18,
              child: ElevatedButton(onPressed:onPressed2, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child:  Text(button2Text,style: DefaultStyles.defaultTextStyleLight.copyWith(color: Colors.white),),)),
          ],
         );
  }
}