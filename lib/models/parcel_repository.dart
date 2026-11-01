import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';

class ParcelRepository {
  ParcelRepository._();

  static List<Parcel> _parcels = [
    Parcel('Котушка Select Reflex', '20450893412091', ParcelCarrier.novaPoshta, ParcelStatus.onTheRoad, DateTime(2026, 10, 1)),
    Parcel('Волейбольний м\'яч Mikasa', '050018234120', ParcelCarrier.ukrPoshta, ParcelStatus.arrived, DateTime(2026, 9, 30)),
    Parcel('Сороконіжки Adidas Predator', '20450918234812', ParcelCarrier.novaPoshta, ParcelStatus.created, DateTime(2026, 9, 28)),
    Parcel('“Роздуми” Марка Аврелія', '0500412894101', ParcelCarrier.ukrPoshta, ParcelStatus.delivered, DateTime(2026, 9, 20)),
    Parcel('Силіконовий килимок для пайки', '0500413564101', ParcelCarrier.novaPoshta, ParcelStatus.delivered, DateTime(2026, 9, 10)),
  ];

  static List<Parcel> getAll() {
    return _parcels;
  }

  static void addParcel(Parcel parcel) {
    _parcels.add(parcel);
  }

  static void removeAt(int index) {
    _parcels.removeAt(index);
  }

  static List<Parcel> getRecent(int num) {
    _parcels.sort(
        (p1, p2) => (p1.date.compareTo(p2.date))
    );

    return _parcels.take(num).toList();
  }

  static int countStatus(ParcelStatus st) {
    return _parcels.where((p) => (p.status == st)).length;
  }
}