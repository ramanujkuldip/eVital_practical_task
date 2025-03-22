

import 'package:flutter/material.dart';

import '../core/theme/color_res.dart';

class BaseText extends Text {
  final String text;
  final Color? color;
  @override
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  final TextOverflow? overflow;
  @override
  final int? maxLines;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  @override
  final TextDirection? textDirection;
  @override
  final bool softWrap;

  BaseText({super.key, 
    required this.text,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.fontFamily,
    this.maxLines,
    this.letterSpacing,
    this.textDecoration,
    this.lineHeight,
    this.textDirection,
    this.softWrap = true,
  }) : super(
          text,
          // textScaleFactor: 0.80,
          textAlign: textAlign ?? TextAlign.center,
          overflow: overflow ?? TextOverflow.ellipsis,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          style: TextStyle(
            decoration: textDecoration ?? TextDecoration.none,
            color: color ?? ColorRes.blackColor,
            fontSize: fontSize ?? 18,
            fontWeight: (fontWeight ?? FontWeight.w400),
            height: lineHeight,
            letterSpacing: letterSpacing ?? 0.1,
          ),
        );
}