import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuldeep_practical/core/constants/constants.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/string_res.dart';
import '../../core/theme/color_res.dart';
import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      dispose: (state) => Get.delete<SplashController>(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  StringRes.handLoadingLottie,
                  repeat: true,
                  animate: true,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                28.heightSpacer,
                Container(
                  width: 200.getSize,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.getSize)
                  ),
                  child: AnimatedBuilder(
                    animation: controller.animation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: controller.animation.value,
                        minHeight: 10,
                        color: ColorRes.primaryColor,
                        backgroundColor: ColorRes.primaryColor.withOpacity(.3),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
