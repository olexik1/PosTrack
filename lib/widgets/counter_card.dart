import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/status_chip.dart';

class CounterCard extends StatelessWidget {
  final ParcelStatus status;
  final int count;

  const CounterCard({
    super.key,
    required this.status,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count.toString(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Icon(
                status.icon,
                color: status.textColor,
                size: 20,
              )
            ],
          ),
          StatusChip(status: status),
        ],
      ),
    );
  }
}