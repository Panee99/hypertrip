import 'package:flutter/material.dart';

class Utilities {
  static bool isKeyboardShowing() {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String capitalizeWords(String text) {
    return text.split(' ').map((word) => capitalizeFirstLetter(word)).join(' ');
  }

  static String capitalizeFirstLetter(String word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
  }
}
