// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayer_timing/networkingPro.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = '';
  GeoCode geoCode = GeoCode();
  @override
  void initState() {
    getLocation(context);

    super.initState();
  }

  getLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // final coordinates = Coordinates(latitude: position.latitude,longitude: position.longitude);
    var address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);
    cityName = address.city!;
    var countryName = address.countryName;
    print(position.latitude);
    callApi(cityName, countryName!);
  }

  callApi(String cityName, String countryName) async {
    await Provider.of<NetworkingProivder>(context, listen: false)
        .getDataFromApi(cityName, countryName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Prayer Timing'),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/background.jpg',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cityName.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: deviceSize.size.width * .5,
                            height: deviceSize.size.height * 0.07,
                            alignment: Alignment.center,
                            color: Colors.black54,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      cityName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 29,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        value.prayerList.isEmpty ? '' : 'Fajr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].fajr)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        value.prayerList.isEmpty ? '' : 'Dhuhr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].dhuhr)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        value.prayerList.isEmpty ? '' : 'Asr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].asar)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        value.prayerList.isEmpty ? '' : 'Maghrib',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].maghrib)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                          deviceSize,
                          value.prayerList.isEmpty ? '' : 'Isha',
                          value.prayerList.isEmpty
                              ? ''
                              : value.prayerList[0].isha,
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Padding prayerContainer(
      MediaQueryData deviceSize, String prayerName, String prayerTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: deviceSize.size.width,
          height: deviceSize.size.height * 0.07,
          color: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  prayerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  prayerTime,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
