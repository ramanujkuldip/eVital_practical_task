import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../commons/base_button.dart';
import '../../commons/base_text.dart';
import '../../core/constants/constants.dart';
// import '../../presentation/login_module/login_view.dart';
import '../../presentation/login_module/login_view.dart';
import '../constants/string_res.dart';
import '../injector.dart';
import '../theme/color_res.dart';

class Utils {
  static AppBar getAppBar({required String title,List<Widget>? actions}) {
    return AppBar(
      title: BaseText(text: title, fontWeight: FontWeight.w600),
      actions: actions,
    );
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static getAssetsImg(String name, bool isJPG) {
    if (isJPG) {
      return "assets/images/$name.jpeg";
    } else {
      return "assets/images/$name.png";
    }
  }

  static getImage(
    String imageName, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
    bool? isJPG,
  }) {
    return Image.asset(
      getAssetsImg(imageName, isJPG ?? false),
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }

  static showCircularProgressLottie(bool isLoading) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      elevation: 0.0,
      content: Center(
        child: Lottie.asset(
          StringRes.circularLoaderLottie,
          height: 70.getSize,
          width: 70.getSize,
        ),
      ),
    );
    if (!isLoading) {
      Get.back();
    } else {
      Get.dialog(dialog, barrierDismissible: false);
    }
  }

  static showErrToast(String? message, {BuildContext? context}) {
    if (message != null && message != "") {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    }
  }

  static showConfirmDialog({
    Function? positiveTap,
    Function? negativeTap,
    String? positiveButtonText,
    String? negativeButtonText,
    String? title,
    String? description,
    bool? showTitleInCenter,
    bool? showDescInCenter,
    bool? showNegativeButton,
    bool? barrierDismissible,
    Widget? icon,
  }) {
    Get.dialog(
      Center(
        child: SizedBox(
          width: Get.width * 0.9,
          child: Material(
            color: ColorRes.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.whiteColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(18.getSize),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      (showTitleInCenter ?? false)
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: icon != null ? (5).getSize : 0),
                    Center(child: icon ?? const SizedBox.shrink()),
                    SizedBox(height: icon != null ? (15).getSize : 0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (showTitleInCenter ?? false)
                            ? Center(
                              child: BaseText(
                                text: title ?? "Are you Sure ?",
                                color: ColorRes.blackColor,
                                textAlign: TextAlign.center,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : BaseText(
                              text: title ?? "Are you Sure ?",
                              color: ColorRes.blackColor,
                              textAlign: TextAlign.center,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                        10.heightSpacer,
                        (showDescInCenter ?? false)
                            ? Center(
                              child: BaseText(
                                text: description ?? '',
                                color: ColorRes.blackColor,
                                textAlign: TextAlign.start,
                                fontSize: 15,
                              ),
                            )
                            : BaseText(
                              text: description ?? '',
                              color: ColorRes.blackColor,
                              textAlign: TextAlign.start,
                              fontSize: 15,
                            ),
                      ],
                    ),
                    25.heightSpacer,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (showNegativeButton ?? true)
                            ? Expanded(
                              child: BaseRaisedButton(
                                onPressed: () {
                                  if (negativeTap != null) {
                                    negativeTap();
                                  }
                                  Get.back();
                                },
                                buttonText: negativeButtonText ?? "Cancel",
                                textColor: ColorRes.whiteColor,
                                buttonColor: ColorRes.textGreyColor,
                              ),
                            )
                            : SizedBox(),
                        (showNegativeButton ?? true)
                            ? 10.widthSpacer
                            : SizedBox(),
                        Expanded(
                          child: BaseRaisedButton(
                            textColor: ColorRes.whiteColor,
                            onPressed: () async {
                              if (positiveTap != null) {
                                positiveTap();
                              }
                              Get.back();
                            },
                            buttonText: positiveButtonText ?? "Yes",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
    );
  }

  static getCacheNetworkImage({
    required String imageUrl,
    required Widget placeholderWidget,
    double? height,
    BoxFit? fit,
    double? width,
  }) {
    if (imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder:
            (context, url, downloadProgress) => Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: ColorRes.whiteColor,
              ),
            ),
        errorWidget: (context, url, error) {
          print("=====error in  image====${error.toString()}");
          return placeholderWidget;
        },
      );
    } else {
      return placeholderWidget;
    }
  }

  static customHeader() {
    return CustomHeader(
      builder: (BuildContext? context, RefreshStatus? mode) {
        return SizedBox(
          height: 55.0,
          child: CupertinoActivityIndicator(color: ColorRes.primaryColor),
        );
      },
      refreshStyle: RefreshStyle.Follow,
    );
  }

  static customFooter() {
    return CustomFooter(
      builder: (BuildContext? context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.loading) {
          body = CircularProgressIndicator(color: ColorRes.primaryColor);
        } else if (mode == LoadStatus.failed) {
          body = BaseText(
            text: "Load Failed!",
            color: ColorRes.textGreyColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          );
        } else if (mode == LoadStatus.canLoading) {
          body = BaseText(
            text: "Release to load more",
            color: ColorRes.textGreyColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          );
        } else {
          body = const SizedBox();
        }
        return SizedBox(height: 55.getSize, child: Center(child: body));
      },
    );
  }

  static transitionWithTo(
    dynamic page, {
    dynamic argument,
    Function? voidCallback,
  }) {
    if (kDebugMode) {
      print("IN TO FUNCTION UTILS");
    }
    Get.to(
      page,
      transition: Transition.fadeIn,
      // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    )!.then((value) {
      if (voidCallback != null) {
        if (value == null) {
          voidCallback("");
        } else {
          voidCallback(value);
        }
      }
    });
  }

  static transitionWithOffAll(
    dynamic page, {
    dynamic argument,
    Function? voidCallback,
    Transition? transition,
  }) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.offAll(
      page,
      transition: transition ?? Transition.fadeIn,
      // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    )!.then((value) {
      if (voidCallback != null) {
        if (value == null) {
          voidCallback("");
        } else {
          voidCallback(value);
        }
      }
    });
  }

  static transitionWithOff(
    dynamic page, {
    dynamic argument,
    Function? voidCallback,
  }) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.off(
      page,
      transition: Transition.fadeIn,
      // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    )!.then((value) {
      if (voidCallback != null) {
        if (value == null) {
          voidCallback("");
        } else {
          voidCallback(value);
        }
      }
    });
  }

  static transitionWithOffUntil(
    dynamic page, {
    dynamic argument,
    Function? voidCallback,
  }) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.offUntil(page, (route) => true)!.then((value) {
      if (voidCallback != null) {
        if (value == null) {
          voidCallback("");
        } else {
          voidCallback(value);
        }
      }
    });
  }

  static transitionWithClose(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.close(page);
  }

  static performLogout({bool isFromAppInterceptors = false}) async {
    Get.back();
    Utils.showCircularProgressLottie(true);
    Injector.prefs?.clear();
    Utils.showCircularProgressLottie(false);
    Utils.transitionWithOffAll(LoginView());
  }
}
