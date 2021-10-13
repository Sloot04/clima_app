import 'package:flutter/material.dart';

class CoorModel with ChangeNotifier {
  late double _lat;
  late double _lon;

  double get lat => _lat;
  double get lon => _lon;

  set lat(double lat) {
    _lat = lat;
    notifyListeners();
  }

  set lon(double lon) {
    _lon = lon;
    notifyListeners();
  }
}
