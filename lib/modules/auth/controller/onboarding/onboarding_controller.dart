
import 'package:community/modules/auth/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class OnBoardingController extends GetxController{

  static OnBoardingController get instance=>Get.find();
  ///Variables
final pageController=PageController();
Rx<int> currentPageIndex=0.obs;


///Update current index with page scroll
void updatePageIndicator(index)=>currentPageIndex.value=index;
  //jump to specific dot selected page
void dotNavigationClick(index){
  currentPageIndex.value=index;
  pageController.jumpTo(index);
}
  //update current index & jump to next page
void nextPage(){
  if(currentPageIndex.value==2){
    final storage=GetStorage();
    storage.write('isFirstTime', false);
Get.offAll(const LoginScreen());
  }else{
    int page=currentPageIndex.value+1;
    pageController.jumpToPage(page);
  }
}
  //update current index & jump to last page
void skipPage(){
  currentPageIndex.value=2;
  pageController.jumpToPage(2);
}
}