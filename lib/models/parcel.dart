import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';


class Parcel {
  final String title;
  final String trackingNumber;
  final ParcelCarrier carrier;
  final ParcelStatus status;
  final DateTime date;

  const Parcel(this.title, this.trackingNumber, this.carrier, this.status,
      this.date);
}