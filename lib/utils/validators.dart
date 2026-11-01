import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введіть email';
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(value.trim())) {
      return 'Введіть коректний email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введіть пароль';
    }

    if(value.length < 6) {
      return 'Пароль має містити не менше 6 символів';
    }

    return null;
  }

  static String? validateRequired(String? value, [String message = 'Це поле обов\'язкове']) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? Function(String?) validateConfirm(TextEditingController password) {
    return (value) {
      if (value == null || value.isEmpty) return 'Підтвердіть пароль';
      if (value != password.text) return 'Паролі не збігаються';
      return null;
    };
  }
}