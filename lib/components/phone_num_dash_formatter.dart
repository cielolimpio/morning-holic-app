import 'package:flutter/services.dart';

class PhoneNumDashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    final int oldTextLength = oldValue.text.length;

    if (newTextLength == 0) {
      return newValue;
    }

    if(![4,9].contains(newTextLength) && newValue.text.substring(newTextLength - 1) == '-') {
      return oldValue;
    }

    // Check if a dash is inserted and remove it
    if (newTextLength < oldTextLength && oldValue.text[oldTextLength - 1] == '-') {
      final String returnText = newValue.text.substring(0, newTextLength - 1);
      return newValue.copyWith(
        text: returnText,
        selection: TextSelection.fromPosition(TextPosition(offset: returnText.length)),
      );
    }

    // Add a dash before the 4th and 9th characters
    if (newValue.text.length == 3 || newValue.text.length == 8) {
      final String returnText = newValue.text + '-';
      return newValue.copyWith(
        text: returnText,
        selection: TextSelection.fromPosition(TextPosition(offset: returnText.length)),
      );
    }

    return newValue;
  }
}