import 'package:mail_tracking_service/models/parcel_status.dart';

class StatusHistory {
  final ParcelStatus status;
  final DateTime date;
  final String? branch;

  const StatusHistory(
      this.status,
      this.date,
      [this.branch]
      );
}