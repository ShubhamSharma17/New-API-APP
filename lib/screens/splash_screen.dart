import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/helper/color.dart';
import 'package:news_api/helper/ui_helper.dart';
import 'package:news_api/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height * 1;
    var width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/splash_pic.jpg",
              fit: BoxFit.cover,
              height: height * .5,
            ),
            verticalSpaceMedium,
            const Text(
              "TOP HEADLINES",
              // style: GoogleFonts.anton(
              //   letterSpacing: 2,
              //   color: gray8F959E,
              // ),
            ),
            verticalSpaceMedium,
            const SpinKitChasingDots(
              color: blue,
            ),
          ],
        ),
      ),
    );
  }
}
