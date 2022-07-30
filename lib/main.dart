import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayer_timing/networkingPro.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkingProivder>(
          create: (context) => NetworkingProivder(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prayer Timing',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
