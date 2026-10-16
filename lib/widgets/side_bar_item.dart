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
    return ListTile(
      selected: selected,
      selectedTileColor: AppColors.primary,
      tileColor: Colors.transparent,
      leading: Icon(
        icon,
        color: selected ? Color(0xFFFFFFFF) : AppColors.textSecondary,
      ),
      title: Text(label, style: TextStyle(
          color: selected ? Color(0xFFFFFFFF) : AppColors.textSecondary
      )),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: onTap,
    );
  }
}