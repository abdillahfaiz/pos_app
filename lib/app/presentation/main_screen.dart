import 'package:flutter/material.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/presentation/history_screen.dart';
import 'package:pos_app/app/presentation/home_screen.dart';
import 'package:pos_app/app/presentation/profile_screen.dart';
import 'package:pos_app/app/presentation/ticket_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int posisiSaatInit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[posisiSaatInit],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColor.grey,
        selectedItemColor: AppColor.mainColor,
        currentIndex: posisiSaatInit,
        onTap: (index) {
          setState(() {
            posisiSaatInit = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Ticket'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  List screen = [
    HomeScreen(),
    TicketScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
}
