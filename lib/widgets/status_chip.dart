import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';

class StatusChip extends StatelessWidget {
  final ParcelStatus status;

  const StatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: status.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}