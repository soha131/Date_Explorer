import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';  // Import the Lottie package

import 'upload_image.dart';
import 'upload_image.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final navigator = Navigator.of(context);
    Future.delayed(const Duration(seconds: 5), () {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => UploadFileScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff503C3C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add Lottie animation widget here
            Lottie.asset(
              'assets/dates.json',
              width: 200, // Adjust width if needed
              height: 200, // Adjust height if needed
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dates",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffF2E0C9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
