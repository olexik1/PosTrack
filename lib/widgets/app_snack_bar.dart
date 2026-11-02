import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

enum AppSnackBarType { error, success }

class AppSnackBar {
  static SnackBar getSnackBar(String message, AppSnackBarType type) {
    return SnackBar(
    content: Row(
      children: [
        Icon(type == AppSnackBarType.error ? Icons.error_outline :
          Icons.check_circle_outline,
            color: type == AppSnackBarType.error ? Colors.red : Colors.green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: type == AppSnackBarType.error ? Colors.red : Colors.green,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    );
  }

  static SnackBar error(String message) {
    return getSnackBar(message, AppSnackBarType.error);
  }

  static SnackBar success(String message) {
    return getSnackBar(message, AppSnackBarType.success);
  }
}