
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension IntExtension on int? {
  Widget get heightSpacer => SizedBox(height: (this ?? 0).toDouble());

  Widget get widthSpacer => SizedBox(width: (this ?? 0).toDouble());

  double get getSize => (this ?? 0).toDouble();

  double get getFontSize => (this ?? 0).toDouble();
}

extension DoubleExtension on double? {
  double get getFontSize => (this ?? 0).toDouble();

  double get getSize => (this ?? 0).toDouble();
}

class NumberRangeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only numbers
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    final number = int.tryParse(text);
    if (number == null || number < 1 || number > 100) {
      return oldValue;
    }
    return newValue;
  }
}