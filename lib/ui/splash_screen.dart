import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_denis/common/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, "/home_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: firstColor,
        body: SafeArea(
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 300,height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/splash_restaurant.json'),
                        Text(
                          "MANGAN CUY",
                          style: font4,
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}
