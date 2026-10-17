import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SideBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        selected: selected,
        leading: Icon(
          icon,
          color: selected ? Colors.white : AppColors.textSecondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: onTap,
      ),
    );
  }
}