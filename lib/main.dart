import 'package:flutter/material.dart';
import 'package:pos_app/app/presentation/main_screen.dart';
import 'package:pos_app/app/presentation/sign_in_screen.dart';
import 'package:pos_app/app/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreen(),
        '/sign-in' : (context) => SignInScreen(),
        '/main' : (context) => MainScreen(),
      },
    );
  }
}