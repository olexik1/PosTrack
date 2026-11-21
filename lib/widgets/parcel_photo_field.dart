import 'package:flutter/material.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';

class ParcelPhotoField extends StatelessWidget {
  final VoidCallback? onAdd;

  const ParcelPhotoField({
    super.key,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 520;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.photoButton,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isNarrow
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: _buildButton(),
              ),
            ],
          )
              : Row(
            children: [
              _buildContent(),
              const Spacer(),
              _buildButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.add_photo_alternate_outlined,
            color: AppColors.textSecondary,
            size: 26,
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Фото посилки або квитанції',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Фото не додано (опціонально)',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return OutlinedButton(
      onPressed: onAdd ?? () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.link,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Додати',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
