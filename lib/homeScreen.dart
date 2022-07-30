// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prayer_timing/networkingPro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NetworkingProivder>(context, listen: false).getDataFromApi();
    super.initState();
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
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        'Fajr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].fajr)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        'Dhuhr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].dhuhr)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        'Asr',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].asar)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                        deviceSize,
                        'Maghrib',
                        value.prayerList.isEmpty
                            ? ''
                            : value.prayerList[0].maghrib)),
                  ),
                  const SizedBox(height: 25),
                  Consumer<NetworkingProivder>(
                    builder: ((context, value, child) => prayerContainer(
                          deviceSize,
                          'Isha',
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
