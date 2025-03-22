
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/constants.dart';

import '../core/theme/color_res.dart';
import '../core/utility/utils.dart';

class BaseTextField extends TextFormField {
  final String? labelText;
  final String? hintText;
  final String? obscuringCharacter;
  @override
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isSecure;
  @override
  final bool enabled;
  @override
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool readOnly;
  final Function()? onEditingComplete;
  @override
  final Function(String?)? onSaved;
  @override
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextCapitalization? textCapitalization;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final Function(String?)? onFieldSubmitted;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? customBorder;
  final String? fontFamily;
  final String? labelFontFamily;
  final String? hintFontFamily;
  final bool isShowBorder;
  final Color? errorBorderColor;
  final Color? focusBorderColor;
  final double? borderWidth;
  final Function(PointerDownEvent)? onTapOutside;
  final AutovalidateMode? validateMode;


  BaseTextField({super.key, 
    this.validateMode,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.errorMaxLines,
    this.suffixIcon,
    required this.controller,
    this.onEditingComplete,
    this.borderRadius,
    this.cursorColor,
    this.onChanged,
    this.onTap,
    this.textCapitalization,
    this.prefixIcon,
    this.textAlign,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.obscuringCharacter,
    this.textColor,
    this.hintTextColor,
    this.textInputType,
    this.isSecure = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.contentPadding,
    this.inputFormatters,
    this.hintMaxLines,
    this.onSaved,
    this.onFieldSubmitted,
    this.minLines,
    this.hintStyle,
    this.labelStyle,
    this.customBorder,
    this.fontFamily,
    this.hintFontFamily,
    this.labelFontFamily,
    this.isShowBorder = false,
    this.errorBorderColor,
    this.focusBorderColor,
    this.borderWidth,
    this.onTapOutside,
  }) : super(
    autovalidateMode: validateMode,
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          style: TextStyle(
            fontSize: (16).getFontSize,
            fontWeight: FontWeight.w400,
            color: textColor ?? ColorRes.blackColor,
            letterSpacing: (0.5).getSize,
          ),
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onTap: onTap,
          textInputAction: textInputAction ?? TextInputAction.next,
          enabled: enabled,
          cursorColor: cursorColor ?? ColorRes.blackColor,
          textAlign: textAlign ?? TextAlign.start,
          readOnly: readOnly,
          maxLines: maxLines ?? 1,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          obscuringCharacter: obscuringCharacter ?? '•',
          inputFormatters: inputFormatters ?? [],
          onTapOutside: (v) {
            if (onTapOutside != null) {
              onTapOutside(v);
            }
            Utils.hideKeyboard();
          },
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefix: SizedBox(width: 18),
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? ColorRes.transparent,
              filled: true,
              counterText: '',
              border: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.blackColor.withOpacity(0.2), width: borderWidth ?? 0.5)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.blackColor.withOpacity(0.2), width: borderWidth ?? 0.5))),
              focusedBorder: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: focusBorderColor ?? ColorRes.primaryColor, width: borderWidth ?? 1.0)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: focusBorderColor ?? ColorRes.primaryColor, width: borderWidth ?? 1.0))),
              enabledBorder: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.blackColor.withOpacity(0.2), width: borderWidth ?? 1.0)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.blackColor.withOpacity(0.2), width: borderWidth ?? 1.0))),
              errorBorder: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: errorBorderColor ?? ColorRes.redColor, width: borderWidth ?? 1.0)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.redColor, width: borderWidth ?? 1.0))),
              disabledBorder: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.disableTextColor, width: borderWidth ?? 1.0)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.disableTextColor, width: borderWidth ?? 1.0))),
              focusedErrorBorder: isShowBorder
                  ? (customBorder ??
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: errorBorderColor ?? ColorRes.redColor, width: borderWidth ?? 1.0)))
                  : (customBorder ??
                      UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius ?? 12.getSize),
                          borderSide: BorderSide(color: borderColor ?? ColorRes.redColor, width: borderWidth ?? 1.0))),
              contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: (18).getSize, horizontal: (20).getSize),
              errorMaxLines: errorMaxLines ?? 1,
              hintText: hintText,
              hintMaxLines: hintMaxLines ?? 1,
              labelText: labelText,
              labelStyle: labelStyle ??
                  TextStyle(
                      fontSize: (15).getFontSize,
                      fontWeight: FontWeight.normal,
                      letterSpacing: (0.5).getSize,
                      color: textColor ?? ColorRes.textGreyColor,
                      fontFamily: labelFontFamily),
              hintStyle: hintStyle ??
                  TextStyle(
                      fontSize: (14).getFontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: (0.5).getSize,
                      color: hintTextColor ?? ColorRes.hintTextColor)),
          validator: (name) {
            validator;
            return null;
          },
        );
}
