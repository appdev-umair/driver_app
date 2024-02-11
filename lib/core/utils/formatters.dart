import 'dart:math';

import 'package:flutter/services.dart';

String generateRandomDateTime() {
  const int year = 2023; // Setting a fixed year for random date generation
  final int month = Random().nextInt(12) + 1; // Random month between 1 and 12
  final int day = Random().nextInt(28) + 1; // Random day between 1 and 28
  final int hour = Random().nextInt(12) + 1; // Random hour between 1 and 12
  final int minute = Random().nextInt(60); // Random minute between 0 and 59
  final int second = Random().nextInt(60); // Random second between 0 and 59

  final String period = hour >= 12 ? 'PM' : 'AM';
  final String formattedHour =
      hour % 12 == 0 ? '12' : (hour % 12).toString().padLeft(2, '0');

  return '$year-$month-$day $formattedHour:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} $period';
}

class InputFormatter {
  static FilteringTextInputFormatter alphabetic =
      FilteringTextInputFormatter.deny(
          RegExp(r'[0-9!@#$%^&*()_+{}\[\]:;<>,.?/~`\-="\\|]'));

  static FilteringTextInputFormatter alphanumeric =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
}

class DateFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length < 5) {
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    } else if (text.length < 7) {
      return newValue.copyWith(
        text: '${text.substring(0, 4)}/${text.substring(4)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else {
      return newValue.copyWith(
        text:
            '${text.substring(0, 4)}/${text.substring(4, 6)}/${text.substring(6)}',
        selection: TextSelection.collapsed(offset: text.length + 2),
      );
    }
  }
}

class SSNFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length < 3) {
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    } else if (text.length < 6) {
      return newValue.copyWith(
        text: '${text.substring(0, 3)}-${text.substring(3)}',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else {
      return newValue.copyWith(
        text:
            '${text.substring(0, 3)}-${text.substring(3, 5)}-${text.substring(5)}',
        selection: TextSelection.collapsed(offset: text.length + 2),
      );
    }
  }
}
