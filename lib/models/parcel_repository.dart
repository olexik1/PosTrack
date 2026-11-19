import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';

class ParcelRepository {
  ParcelRepository._();

  static final List<Parcel> _parcels = [
    Parcel(
        1,
        'Котушка Select Reflex',
        '20450893412091',
        ParcelCarrier.novaPoshta,
        ParcelStatus.onTheRoad,
        DateTime(2026, 10, 1),
        "Select shop",
        "Олег"
    ),
    Parcel(
        2,
        'Волейбольний м\'яч Mikasa',
        '050018234120',
        ParcelCarrier.ukrPoshta,
        ParcelStatus.arrived,
        DateTime(2026, 9, 30),
        "Rozetka",
        "Олег"
    ),
    Parcel(
        3,
        'Сороконіжки Adidas Predator',
        '20450918234812',
        ParcelCarrier.novaPoshta,
        ParcelStatus.created,
        DateTime(2026, 9, 28),
        "Adidas",
        "Олег"
    ),
    Parcel(
        4,
        '“Роздуми” Марка Аврелія',
        '0500412894101',
        ParcelCarrier.ukrPoshta,
        ParcelStatus.delivered,
        DateTime(2026, 9, 20),
        'Книгарня "Є"',
        "Олег"
    ),
    Parcel(
        5,
        'Силіконовий килимок для пайки',
        '0500413564101',
        ParcelCarrier.novaPoshta,
        ParcelStatus.delivered,
        DateTime(2026, 9, 10),
        "MENStudio",
        "Олег"
    ),
  ];

  static List<Parcel> getAll() {
    return _parcels;
  }

  static Parcel? getById(int id) {
    return _parcels.where((p) => (p.id == id)).firstOrNull;
  }

  static void addParcel(Parcel parcel) {
    _parcels.add(parcel);
  }

  static void updateParcel(Parcel parcel) {
    int index = _parcels.indexWhere((p) => (p.id == parcel.id));

    if(index != 1) {
      _parcels[index] = parcel;
    }
  }

  static void removeAt(int index) {
    _parcels.removeAt(index);
  }

  static void removeById(int id) {
    _parcels.removeWhere((p) => (p.id == id));
  }

  static List<Parcel> getRecent(int num) {
    var parcelsCopy = _parcels;

    parcelsCopy.sort(
        (p1, p2) => (p1.date.compareTo(p2.date))
    );

    return parcelsCopy.take(num).toList();
  }

  static int countStatus(ParcelStatus st) {
    return _parcels.where((p) => (p.status == st)).length;
  }
}