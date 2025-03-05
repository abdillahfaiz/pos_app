import 'package:flutter/material.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/sign-in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: [
      //     Align(
      //       alignment: Alignment.center,
      //       child: Image.asset(AssetsConst.logoBlue),
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Image.asset(AssetsConst.fromLogo),
      //     ),
      //   ],
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(AssetsConst.logoBlue),
            Spacer(),
            Image.asset(AssetsConst.fromLogo),
          ],
        ),
      ),
    );
  }
}
