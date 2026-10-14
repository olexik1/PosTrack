import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class FormTitle extends StatelessWidget {
  final String mainText;
  final String? subText;

  const FormTitle({
    super.key,
    required this.mainText,
    this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          mainText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (subText case final text?)
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
      ],
    );
  }
}