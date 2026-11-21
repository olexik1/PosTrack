import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

Future<bool> showDeleteParcelDialog(
    BuildContext context, {
      required String parcelTitle,
    }) async {
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.exitBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.exit,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Видалити посилку?',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Ви впевнені, що хочете видалити посилку «$parcelTitle»? Цю дію не можна буде скасувати.',
                style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.photoButton,
                      foregroundColor: AppColors.textPrimary,
                      minimumSize: const Size(0, 48),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: shape,
                    ),
                    child: const Text('Скасувати'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.exit,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: shape,
                    ),
                    child: const Text('Видалити'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return confirmed ?? false;
}