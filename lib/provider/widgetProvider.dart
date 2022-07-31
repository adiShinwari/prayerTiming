import 'package:flutter/material.dart';

class WidgetProvider with ChangeNotifier {
  String _cityName = '';
  String _countryName = '';

  get getCityName {
    return _cityName;
  }

  void setCityName(String cityName) {
    _cityName = cityName;
    
    notifyListeners();
  }

  get getCountryName {
    return _countryName;
  }

  void setCountryName(String countryName) {
    _countryName = countryName;
    notifyListeners();
  }
}
