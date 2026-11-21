import 'package:flutter/material.dart';

class CurrentParcelProvider extends ChangeNotifier {
  int? currentParcelId;
  CurrentParcelProvider({this.currentParcelId});

  void setNew(int id) {
    currentParcelId = id;
    notifyListeners();
  }

  void remove() {
    currentParcelId = null;
    notifyListeners();
  }
}