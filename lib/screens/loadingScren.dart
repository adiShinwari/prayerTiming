// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayer_timing/provider/networkingPro.dart';
import 'package:prayer_timing/provider/widgetProvider.dart';
import 'package:prayer_timing/screens/homeScreen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = './loadingScreen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  GeoCode geoCode = GeoCode();

  @override
  void initState() {
  
    getLocation(context);
    super.initState();
  }

  getLocation(BuildContext context) async {
    final widgetProvider = Provider.of<WidgetProvider>(context, listen: false);
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // final coordinates = Coordinates(latitude: position.latitude,longitude: position.longitude);
    var address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);
    widgetProvider.setCityName(address.city!);
    widgetProvider.setCountryName(address.countryName!);

    callApi(widgetProvider.getCityName, widgetProvider.getCountryName!);
  }

  callApi(String cityName, String countryName) async {
    await Provider.of<NetworkingProivder>(context, listen: false)
        .getDataFromApi(cityName, countryName);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prayer Timing',
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
