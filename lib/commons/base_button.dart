

import 'package:flutter/material.dart';
import '../core/constants/constants.dart';


import '../core/theme/color_res.dart';
import 'base_text.dart';

class BaseRaisedButton extends ElevatedButton {
  @override
  final VoidCallback? onPressed;
  final String? buttonText;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? buttonVerticalPadding;
  final double? buttonHorizontalPadding;
  final Widget? icon;
  bool isExpanded = true;
  final Widget? trailingIcon;
  final double? borderWidth;
  final MaterialTapTargetSize? tapTargetSize;
  final WidgetStateProperty<OutlinedBorder?>? shape;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? fontFamily;

  BaseRaisedButton({
    super.key,
    this.buttonText,
    this.onPressed,
    this.fontSize,
    this.fontWeight,
    this.buttonColor,
    this.buttonVerticalPadding,
    this.buttonHorizontalPadding,
    this.borderRadius,
    this.textColor,
    this.borderColor,
    this.icon,
    this.isExpanded = true,
    this.height,
    this.width,
    this.trailingIcon,
    // this.fixedSize,
    this.borderWidth,
    this.tapTargetSize,
    this.shape,
    this.maxLines,
    this.overflow,
    this.fontFamily,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              ((icon != null) && buttonText != null && buttonText.isNotEmpty) ? 8.widthSpacer : const SizedBox(),
              if (buttonText != null)
                isExpanded
                    ? Flexible(
                        child: BaseText(
                          text: buttonText,
                          color: textColor ?? ColorRes.whiteColor,
                          fontSize: fontSize ?? 16,
                          fontWeight: fontWeight ?? FontWeight.w600,
                          textAlign: TextAlign.center,
                          maxLines: maxLines,
                          overflow: overflow,
                        ),
                      )
                    : BaseText(
                        text: buttonText,
                        color: textColor ?? ColorRes.whiteColor,
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
              ((trailingIcon != null) && buttonText != null && buttonText.isNotEmpty) ? 8.widthSpacer : const SizedBox(),
              trailingIcon ?? const SizedBox(),
            ],
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            tapTargetSize: tapTargetSize,
            shape: shape ??
                WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                    side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 1,
                    ),
                  ),
                ),
            backgroundColor: WidgetStateProperty.all(buttonColor ?? ColorRes.primaryColor),
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                vertical: buttonVerticalPadding ?? 15,
                horizontal: buttonHorizontalPadding ?? 16,
              ),
            ),
          ),
        );
}
