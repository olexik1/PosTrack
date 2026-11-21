import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/form_action_button.dart';
import 'package:flutter/services.dart';
import 'package:mail_tracking_service/widgets/app_snack_bar.dart';

class InfoField extends StatelessWidget {
  final String title;
  final String info;
  final bool? copy;

  const InfoField({
    super.key,
    required this.title,
    required this.info,
    this.copy
  });

  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: info));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBar.success('Трек-номер скопійовано'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.photoButton,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12
                  ),
                ),
                Text(
                  info,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            if(copy != null) const Spacer(),
            if(copy != null) FormActionButton(
              label: "Копіювати",
              backgroundColor: Colors.white,
              foregroundColor: AppColors.link,
              onPressed: () => _copyToClipboard(context),
              fullWidth: false,
              icon: Icons.copy_outlined,
            ),
          ],
        )
    );
  }
}