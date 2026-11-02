import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

const avatarUrls = [
  'https://api.dicebear.com/9.x/adventurer/png?seed=Felix',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Aneka',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Milo',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Luna',
  'https://api.dicebear.com/9.x/adventurer/png?seed=Oscar',
];

Future<String?> showAvatarPicker(BuildContext context, {String? selectedUrl}) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Оберіть аватар'),
      content: SizedBox(
        width: 400,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final url in avatarUrls)
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(dialogContext).pop(url),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: url == selectedUrl
                          ? AppColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.avatar,
                    backgroundImage: NetworkImage(url),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Скасувати'),
        ),
      ],
    ),
  );
}