import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuldeep_practical/commons/base_text.dart';
import 'package:kuldeep_practical/core/constants/constants.dart';

import '../../commons/base_button.dart';
import '../../commons/base_textfield.dart';
import '../../core/constants/string_res.dart';
import '../../core/utility/utils.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      dispose: (state) => Get.delete<LoginController>(),
      builder: (controller) {
        return Scaffold(body: mainBody(context, controller));
      },
    );
  }

  SafeArea mainBody(BuildContext context, LoginController controller) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      text: "eVital",
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                    20.heightSpacer,
                    formView(controller),
                    16.heightSpacer,
                    getLoginButton(controller),
                    16.heightSpacer,
                    if (controller.utmSource.isNotEmpty ||
                        controller.utmMedium.isNotEmpty ||
                        controller.utmCampaign.isNotEmpty)
                    utmDetailsView(controller),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  utmDetailsView(LoginController controller) {
    return Obx(
      () => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: "UTM details from Links",
              fontWeight: FontWeight.w500,
            ),
            10.heightSpacer,
            BaseText(
              text: "UTM Source: ${controller.utmSource.value ?? "--"}",
              fontWeight: FontWeight.w500,
            ),
            7.heightSpacer,
            BaseText(
              text: "UTM Medium: ${controller.utmMedium.value ?? "--"}",
              fontWeight: FontWeight.w500,
            ),
            7.heightSpacer,
            BaseText(
              text: "UTM Campaign: ${controller.utmCampaign.value ?? "--"}",
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Card formView(LoginController controller) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              BaseTextField(
                controller: controller.phoneNumberController,
                hintText: 'Enter your Phone number',
                textInputType: TextInputType.phone,
                isShowBorder: true,
                contentPadding: EdgeInsets.zero,
                validator: controller.validatePhoneNumber,
              ),
              const SizedBox(height: 10),
              BaseTextField(
                controller: controller.passwordController,
                hintText: 'Enter your password',
                isShowBorder: true,
                textInputAction: TextInputAction.done,
                isSecure: !(controller.isShowPassword),
                validator: controller.validatePassword,
                errorMaxLines: 3,
                contentPadding: EdgeInsets.zero,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (controller.isShowPassword) {
                      controller.isShowHidePassword(false);
                    } else {
                      controller.isShowHidePassword(true);
                    }
                  },
                  child: Align(
                    widthFactor: 1,
                    child: Utils.getImage(
                      controller.isShowPassword
                          ? StringRes.eyeSlashIco
                          : StringRes.eyeIco,
                      width: 24.getSize,
                      height: 24.getSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLoginButton(LoginController controller) {
    return Row(
      children: [
        Expanded(
          child: BaseRaisedButton(
            onPressed: controller.login,
            buttonText: "Login",
          ),
        ),
      ],
    );
  }

}
