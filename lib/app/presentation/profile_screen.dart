import 'package:flutter/material.dart';
import 'package:pos_app/data/datasource/local_storage/local_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            LocalStorage().removeToken();
            Navigator.pushReplacementNamed(context, '/sign-in');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
