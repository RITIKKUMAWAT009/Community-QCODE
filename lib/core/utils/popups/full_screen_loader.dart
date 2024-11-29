
import 'package:community/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/aniamtion_widget.dart';


class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    print('Inside the fullLoader class');
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: HelperFunctions.isDarkMode(Get.context!)
              ? Colors.black
              : Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
                  AnimationLoaderWidget(text: text, animation: animation)

            ],
          ),
        ),
      ),
    );
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();//closing dialog
  }
}
