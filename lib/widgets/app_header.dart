import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final VoidCallback onLogout;

  const AppHeader({
    super.key,
    this.photoUrl,
    required this.name,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          right: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.link,
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
              child: photoUrl == null ? const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 24,
              ) : null,
            ),
            Text(
              name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: onLogout,
              tooltip: "Вийти",
            ),
          ],
        ),
      ),
    );
  }
}