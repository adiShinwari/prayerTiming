import 'package:flutter/material.dart';
import 'package:prayer_timing/provider/networkingPro.dart';
import 'package:prayer_timing/screens/homeScreen.dart';
import 'package:prayer_timing/screens/loadingScren.dart';
import 'package:prayer_timing/screens/splashScreen.dart';
import 'package:prayer_timing/provider/widgetProvider.dart';
import 'package:provider/provider.dart';

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
        ),
        ChangeNotifierProvider<WidgetProvider>(
            create: ((context) => WidgetProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prayer Timing',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          LoadingScreen.routeName: (context) => const LoadingScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
        },
      ),
    );
  }
}
