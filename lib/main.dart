import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos_app/app/presentation/main_screen.dart';
import 'package:pos_app/app/presentation/order_detail_screen.dart';
import 'package:pos_app/app/presentation/sign_in_screen.dart';
import 'package:pos_app/app/presentation/splash_screen.dart';
import 'package:pos_app/data/datasource/local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/sign-in': (context) => SignInScreen(),
        '/main': (context) => MainScreen(),
        '/order-detail': (context) => OrderDetailScreen(),
      },
    );
  }
}
