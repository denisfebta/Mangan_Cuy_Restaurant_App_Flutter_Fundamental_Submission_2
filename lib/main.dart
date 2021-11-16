import 'package:flutter/material.dart';
import 'package:restaurant_denis/ui/home_page.dart';
import 'package:restaurant_denis/ui/detail_page.dart';
import 'package:restaurant_denis/ui/splash_screen.dart';
import 'common/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: firstColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splash_screen",
      routes: {
        "/splash_screen": (context) => SplashScreen(),
        "/home_page": (context) => HomePage(),
        "/detail_page": (context) => DetailPage(
              restaurant: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}
