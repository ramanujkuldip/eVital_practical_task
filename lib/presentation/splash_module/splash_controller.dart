import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuldeep_practical/presentation/home_module/home_view.dart';
import 'package:kuldeep_practical/presentation/login_module/login_view.dart';

import '../../core/injector.dart';
import '../../core/utility/utils.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  var isLoading = false.obs;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();


    animation.addListener(() {

      print("Animation val-> ${animation.value}");
      if(animation.value == 1){
        navigateTo();

      }
    });

    super.onInit();
  }

  navigateTo() {
    print("isLoggedIn-> ${Injector.isLoggedIn}");
    // if (Injector.isLoggedIn) {
    //   Utils.transitionWithOffAll(HomeView());
    // } else {
      Utils.transitionWithOffAll(LoginView());
    // }
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
