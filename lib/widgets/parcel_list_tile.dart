import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';
import 'package:intl/intl.dart';

class ParcelListTile extends StatelessWidget {
  final Parcel parcel;
  final VoidCallback? onDetails;

  const ParcelListTile({
    super.key,
    required this.parcel,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 16,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.photoButton,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              parcel.status.icon,
              color: parcel.status.textColor,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Text(
                        parcel.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StatusChip(status: parcel.status),
                  ],
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    _meta("ТТН:", parcel.trackingNumber, true),
                    _separator(),
                    _meta(null, parcel.carrier.label, false),
                    _separator(),
                    _meta("Відправник:", parcel.sender, false),
                    _separator(),
                    _meta("Кому:", parcel.recipient, false),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              const Text(
                'Дата оновлення',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                DateFormat('dd.MM.yyyy').format(parcel.date),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          OutlinedButton.icon(
            onPressed: onDetails,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Переглянути'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.link,
              backgroundColor: AppColors.photoButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(String? parameter, String text, bool bold) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(
          parameter ?? "",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: bold == true ? FontWeight.bold : FontWeight.normal
          ),
        ),
        Text(
          text,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _separator() {
    return Text('•', style: TextStyle(color: AppColors.textSecondary));
  }
}

