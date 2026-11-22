import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class ParcelPhotoUpload extends StatelessWidget {
  final VoidCallback? onTap;

  const ParcelPhotoUpload({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Фото квитанції або вмісту (опціонально)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: AppColors.photoButton,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                          color: AppColors.border,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.link,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Головний текст
                    const Text(
                      'Натисніть для вибору файлу або перетягніть сюди',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'JPG, PNG до 5 МБ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}