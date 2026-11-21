import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/status_history.dart';

class Parcel {
  final int id;
  final String title;
  final String trackingNumber;
  final ParcelCarrier carrier;
  final ParcelStatus status;
  final DateTime date;
  final String sender;
  final String recipient;
  final String note;
  final List<StatusHistory>? statusHistory;

  const Parcel(
      this.id,
      this.title,
      this.trackingNumber,
      this.carrier,
      this.status,
      this.date,
      this.sender,
      this.recipient,
      this.note,
      [this.statusHistory]
      );
}