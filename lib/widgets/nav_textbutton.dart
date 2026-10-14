import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class NavTextButton extends StatelessWidget {
  final String destination;
  final String label;
  final IconData? icon;
  final bool centered;
  final bool bold;

  const NavTextButton({
    super.key,
    required this.destination,
    required this.label,
    this.icon,
    this.centered = false,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = TextButton.icon(
      onPressed: () => context.push(destination),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.link,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: icon != null
          ? Icon(icon, size: 18)
          : const SizedBox.shrink(),
      label: Text(
        label,
        style: (bold) ? const TextStyle(
          fontWeight: FontWeight.bold,
        ) : null,
      ),
    );

    if (centered) {
      return Center(child: button);
    }

    return button;
  }
}