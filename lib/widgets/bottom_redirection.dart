import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class BottomRedirection extends StatelessWidget {
  final String textLabel;
  final String buttonLabel;
  final VoidCallback? onPressed;

  const BottomRedirection({
    super.key,
    required this.textLabel,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          textLabel,
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}