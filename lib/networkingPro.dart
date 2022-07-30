// ignore_for_file: file_names

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:prayer_timing/prayer.dart';

class NetworkingProivder extends ChangeNotifier {
  static const url =
      'https://api.aladhan.com/v1/timingsByCity?city=peshawar&country=pakistan&method=8';
  Future fetchDataFromApi() async {
    final response = await dio.Dio().get(url);

    return response;
  }

  List<Prayer> prayerList = [];

  String convertTimeToAmPmStamp(String time) {
    var temp = int.parse(time.split(':')[0]);
    String? t;
    if (temp >= 12 && temp < 24) {
      t = " PM";
    } else {
      t = " AM";
    }
    if (temp > 12) {
      temp = temp - 12;
      if (temp < 10) {
        time = time.replaceRange(0, 2, "0$temp");
        time += t;
      } else {
        time = time.replaceRange(0, 2, "$temp");
        time += t;
      }
    } else if (temp == 00) {
      time = time.replaceRange(0, 2, '12');
      time += t;
    } else {
      time += t;
    }
    return time;
  }

  getDataFromApi() async {
    final response = await fetchDataFromApi();
    Prayer prayer = Prayer(
      asar: convertTimeToAmPmStamp(response.data['data']['timings']['Asr']),
      dhuhr: convertTimeToAmPmStamp(response.data['data']['timings']['Dhuhr']),
      fajr: convertTimeToAmPmStamp(response.data['data']['timings']['Fajr']),
      isha: convertTimeToAmPmStamp(response.data['data']['timings']['Isha']),
      maghrib:
          convertTimeToAmPmStamp(response.data['data']['timings']['Maghrib']),
    );

    prayerList.insert(0, prayer);

    notifyListeners();
  }
}
