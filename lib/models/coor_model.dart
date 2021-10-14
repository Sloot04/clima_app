import 'package:flutter/material.dart';

class CoorModel with ChangeNotifier {
  double _lat = 0;
  double _lon = 0;
  bool _isWeather = false;

  double get lat => _lat;
  double get lon => _lon;
  bool get isWeather => _isWeather;

  set lat(double value) => _lat = value;
  set lon(double value) => _lon = value;

  set isWeather(bool value) {
    _isWeather = value;
    notifyListeners();
  }
}
