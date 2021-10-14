import 'package:flutter/material.dart';

class CoorModel with ChangeNotifier {
  late double _lat;
  late double _lon;
  bool _isWeather = false;

  double get lat => _lat;
  double get lon => _lon;
  bool get isWeather => _isWeather;

  set lat(double value) => _lat;
  set lon(double value) => _lon;

  set isWeather(bool value) {
    _isWeather = value;
    notifyListeners();
  }
}
