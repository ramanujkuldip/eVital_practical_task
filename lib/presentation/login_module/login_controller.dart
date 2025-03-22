import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../core/injector.dart';
import '../../core/utility/utils.dart';
import '../home_module/home_view.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String phone = "9033006262";
  String password = "eVital@12";
  bool isShowPassword = false;
  final AppLinks _appLinks = AppLinks();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var utmSource = "".obs;
  var utmMedium = "".obs;
  var utmCampaign = "".obs;

  @override
  void onInit() {
    initDeepLinks();
    super.onInit();
  }

  login() async {
    if (!formKey.currentState!.validate()) {
      return;
    } else if (phone != phoneNumberController.text.trim() ||
        passwordController.text.trim() != password) {
      Utils.showErrToast("Wrong phone number or password");
      return;
    }
    Utils.showCircularProgressLottie(true);
    Injector.isLoggedIn = true;
    await Future.delayed(Duration(seconds: 2));
    Utils.transitionWithOffAll(HomeView());
    Utils.showCircularProgressLottie(false);
  }

  isShowHidePassword(bool val) {
    isShowPassword = !isShowPassword;
    update();
  }

  String? validatePhoneNumber(String? value) {
    final RegExp phoneRegExp = RegExp(r'^[0-9]{10,15}$');

    if (value != null && value.isEmpty) {
      return "Phone number cannot be empty";
    } else if (value != null && !phoneRegExp.hasMatch(value)) {
      return "Enter a valid phone number";
    }

    return null;
  }

  String? validatePassword(String? value) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (value != null && value.isEmpty) {
      return "Password cannot be empty";
    } else if (value != null && !passwordRegExp.hasMatch(value)) {
      return "Password must be at least 8 characters, include uppercase, lowercase, a number, and a special character.";
    }
    return null;
  }

  void initDeepLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    print("initialUri $initialUri");
    if (initialUri != null) {
      handleDeepLink(initialUri);
    }

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    });
  }

  void handleDeepLink(Uri uri) {
    print("uri-->> $uri");
    utmSource.value = uri.queryParameters['utm_source'] ?? "";
    utmMedium.value = uri.queryParameters['utm_medium'] ?? "";
    utmCampaign.value = uri.queryParameters['utm_campaign'] ?? "";
    update();
    print("UTM Source: ${utmSource.value}");
    print("UTM Medium: ${utmMedium.value}");
    print("UTM Campaign: ${utmCampaign.value}");
  }
}
