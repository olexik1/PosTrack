import 'package:flutter/material.dart';
import 'package:mail_tracking_service/models/parcel.dart';
import 'package:mail_tracking_service/models/parcel_carrier.dart';
import 'package:mail_tracking_service/models/parcel_status.dart';
import 'package:mail_tracking_service/models/parcel_repository.dart';

enum SortOrder {
  newFirst('Спочатку нові (за датою)'), oldFirst('Спочатку старі (за датою)');
  final String label;
  const SortOrder(this.label);
}

class ParcelProvider extends ChangeNotifier {
  String searchQuery;
  ParcelStatus? selectedStatus;
  ParcelCarrier? selectedCarrier;
  SortOrder? sortOrder;
  int currentPage;
  int itemsPerPage;

  ParcelProvider({
    this.searchQuery = '',
    this.selectedStatus,
    this.selectedCarrier,
    this.sortOrder = SortOrder.newFirst,
    this.currentPage = 1,
    this.itemsPerPage = 4,
  });

  // Сеттери
  void setSearchQuery(String query) {
    searchQuery = query;
    currentPage = 1;
    notifyListeners();
  }

  void setStatusFilter(ParcelStatus? status) {
    selectedStatus = status;
    currentPage = 1;
    notifyListeners();
  }

  void setCarrierFilter(ParcelCarrier? carrier) {
    selectedCarrier = carrier;
    currentPage = 1;
    notifyListeners();
  }

  void setSortOrder(SortOrder? order) {
    sortOrder = order;
    currentPage = 1;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    if(page <= totalPages && page >= 1) {
      currentPage = page;
      notifyListeners();
    }
  }

  void setItemsPerPage(int items) {
    if(items >= 1) {
      itemsPerPage = items;
      currentPage = 1;
      notifyListeners();
    }
  }

  void nextPage() {
    if (hasNextPage) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (hasPreviousPage) {
      currentPage--;
      notifyListeners();
    }
  }

  void resetFilters() {
    searchQuery = "";
    selectedStatus = null;
    selectedCarrier = null;
    sortOrder = SortOrder.newFirst;
    currentPage = 1;
    notifyListeners();
  }

  // Геттери
  List<Parcel> get _parcels => ParcelRepository.getAll();

  List<Parcel> get filteredParcels {
    final query = searchQuery.trim().toLowerCase();

    return _parcels.where((p) {
      final matchesSearch = query.isEmpty ||
      p.title.toLowerCase().contains(query) ||
      p.trackingNumber.toLowerCase().contains(query);

      final matchesStatus = selectedStatus == null ||
      p.status == selectedStatus;

      final matchesCarrier = selectedCarrier == null ||
      p.carrier == selectedCarrier;

      return matchesSearch && matchesStatus && matchesCarrier;
    }).toList();
  }

  List<Parcel> get sortedParcels {
    var parcels = [...filteredParcels];

    if(sortOrder == SortOrder.newFirst) {
      parcels.sort((p1, p2) => p2.date.compareTo(p1.date));
    }
    else {
      parcels.sort((p1, p2) => p1.date.compareTo(p2.date));
    }

    return parcels;
  }

  List<Parcel> get visibleParcels => sortedParcels.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
  int get totalPages => (itemsPerPage == 0) ? 0 : (sortedParcels.length / itemsPerPage).ceil();
  int get totalFilteredParcels => filteredParcels.length;

  bool get hasNextPage {
    if(currentPage + 1 <= totalPages) {
      return true;
    }
    else {
      return false;
    }
  }

  bool get hasPreviousPage {
    if(currentPage - 1 > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  // Функції
  int countByStatus(ParcelStatus status) {
    return _parcels.where((p) => p.status == status).toList().length;
  }

  List<Parcel> recentParcels(int n) {
    return _parcels.take(n).toList();
  }
}