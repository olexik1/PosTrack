import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/status_history.dart';

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
      'Select shop',
      'Олег',
      'Перевірити цілісність упаковки при отриманні.',
      [
        StatusHistory(
          ParcelStatus.created,
          DateTime(2026, 10, 1, 10, 15),
        ),
        StatusHistory(
          ParcelStatus.accepted,
          DateTime(2026, 10, 1, 14, 30),
          'Відділення №12, Львів',
        ),
        StatusHistory(
          ParcelStatus.onTheRoad,
          DateTime(2026, 10, 2, 8, 45),
        ),
      ],
    ),

    Parcel(
      2,
      'Волейбольний м’яч Mikasa',
      '050018234120',
      ParcelCarrier.ukrPoshta,
      ParcelStatus.arrived,
      DateTime(2026, 9, 30),
      'Rozetka',
      'Олег',
      'Забрати у відділенні. Перед отриманням перевірити комплектацію.',
      [
        StatusHistory(
          ParcelStatus.created,
          DateTime(2026, 9, 30, 9, 20),
        ),
        StatusHistory(
          ParcelStatus.accepted,
          DateTime(2026, 9, 30, 13, 10),
          'Відділення №5, Київ',
        ),
        StatusHistory(
          ParcelStatus.onTheRoad,
          DateTime(2026, 10, 1, 7, 40),
        ),
        StatusHistory(
          ParcelStatus.arrived,
          DateTime(2026, 10, 2, 11, 25),
          'Відділення №8, Львів',
        ),
      ],
    ),

    Parcel(
      3,
      'Сороконіжки Adidas Predator',
      '20450918234812',
      ParcelCarrier.novaPoshta,
      ParcelStatus.created,
      DateTime(2026, 9, 28),
      'Adidas',
      'Олег',
      'Потрібно приміряти та перевірити розмір.',
      [
        StatusHistory(
          ParcelStatus.created,
          DateTime(2026, 9, 28, 16, 35),
        ),
      ],
    ),

    Parcel(
      4,
      '“Роздуми” Марка Аврелія',
      '0500412894101',
      ParcelCarrier.ukrPoshta,
      ParcelStatus.delivered,
      DateTime(2026, 9, 20),
      'Книгарня "Є"',
      'Олег',
      'Замовлення отримано без пошкоджень.',
      [
        StatusHistory(
          ParcelStatus.created,
          DateTime(2026, 9, 20, 10, 5),
        ),
        StatusHistory(
          ParcelStatus.accepted,
          DateTime(2026, 9, 20, 15, 20),
          'Відділення №3, Київ',
        ),
        StatusHistory(
          ParcelStatus.onTheRoad,
          DateTime(2026, 9, 21, 6, 50),
        ),
        StatusHistory(
          ParcelStatus.arrived,
          DateTime(2026, 9, 22, 12, 15),
          'Відділення №14, Львів',
        ),
        StatusHistory(
          ParcelStatus.delivered,
          DateTime(2026, 9, 22, 17, 40),
          'Відділення №14, Львів',
        ),
      ],
    ),

    Parcel(
      5,
      'Силіконовий килимок для пайки',
      '0500413564101',
      ParcelCarrier.novaPoshta,
      ParcelStatus.delivered,
      DateTime(2026, 9, 10),
      'MENStudio',
      'Олег',
      '',
      [
        StatusHistory(
          ParcelStatus.created,
          DateTime(2026, 9, 10, 8, 30),
        ),
        StatusHistory(
          ParcelStatus.accepted,
          DateTime(2026, 9, 10, 12, 45),
          'Відділення №21, Київ',
        ),
        StatusHistory(
          ParcelStatus.onTheRoad,
          DateTime(2026, 9, 11, 7, 15),
        ),
        StatusHistory(
          ParcelStatus.arrived,
          DateTime(2026, 9, 12, 10, 20),
          'Відділення №6, Львів',
        ),
        StatusHistory(
          ParcelStatus.delivered,
          DateTime(2026, 9, 12, 14, 55),
          'Відділення №6, Львів',
        ),
      ],
    ),
  ];


  static List<Parcel> getAll() {
    return _parcels;
  }

  static Parcel? getById(int id) {
    return _parcels.where((p) => p.id == id).firstOrNull;
  }

  static void addParcel(Parcel parcel) {
    _parcels.add(parcel);
  }

  static void updateParcel(Parcel parcel) {
    int index = _parcels.indexWhere((p) => p.id == parcel.id);

    if (index != -1) {
      _parcels[index] = parcel;
    }
  }

  static void removeAt(int index) {
    _parcels.removeAt(index);
  }

  static void removeById(int id) {
    _parcels.removeWhere((p) => p.id == id);
  }

  static List<Parcel> getRecent(int num) {
    var parcelsCopy = [..._parcels];

    parcelsCopy.sort(
          (p1, p2) => p2.date.compareTo(p1.date),
    );

    return parcelsCopy.take(num).toList();
  }

  static int countStatus(ParcelStatus st) {
    return _parcels.where((p) => p.status == st).length;
  }
}
