import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subTitle;
  final String actionLabel;
  final VoidCallback? onAction;
  final Color btnTextColor;
  final Color iconBackground;
  final Color iconColor;

  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.actionLabel,
    required this.onAction,
    required this.btnTextColor,
    required this.iconBackground,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.photoButton,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              spacing: 16,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if(subTitle != null) Text(
                        subTitle!,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: btnTextColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}