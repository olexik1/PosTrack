import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';

class ParcelFormValues {
  final String title;
  final String trackingNumber;
  final ParcelCarrier carrier;
  final String sender;
  final String recipient;
  final DateTime date;
  final ParcelStatus status;
  final String note;

  const ParcelFormValues({
    required this.title,
    required this.trackingNumber,
    required this.carrier,
    required this.sender,
    required this.recipient,
    required this.date,
    required this.status,
    required this.note,
  });
}