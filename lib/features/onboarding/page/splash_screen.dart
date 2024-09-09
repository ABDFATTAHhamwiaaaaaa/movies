import 'package:flutter/material.dart';

import 'onboarding_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplahScreen extends StatefulWidget {
  const  SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return  OnboardingScreen();
        },
      ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.png').animate().fade(),
            // const Text(
            //   'MOVIZONE',
            //   style: TextStyle(fontSize: 33, color: Colors.blueAccent),
            // )
          ],
        ),
      ),
    );
  }
}
