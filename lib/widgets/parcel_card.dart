import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';

class ParcelCard extends StatelessWidget {
  final Parcel parcel;
  final VoidCallback? onDetails;

  const ParcelCard({
    super.key,
    required this.parcel,
    this.onDetails,
  });

  static const _months = [
    'січня', 'лютого', 'березня', 'квітня', 'травня', 'червня',
    'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня',
  ];

  @override
  Widget build(BuildContext context) {
    final isCreated = parcel.status == ParcelStatus.created;
    final dateText =
        '${isCreated ? 'Створено' : 'Оновлено'} ${parcel.date.day} ${_months[parcel.date.month - 1]}';

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
            child: Text(
              parcel.carrier.abbreviation,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
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
                    _meta(Icons.tag, parcel.trackingNumber),
                    _meta(Icons.local_shipping_outlined, parcel.carrier.label),
                    _meta(
                      isCreated ? Icons.calendar_today_outlined : Icons.update,
                      dateText,
                    ),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: onDetails,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Докладніше'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.cardBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        Text(
          text,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}