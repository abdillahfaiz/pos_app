import 'package:flutter/material.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Stack(
        children: [
          SizedBox(
            height: 213,
            child: Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: Image.asset(AssetsConst.logoWhite),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 44),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: 'Email Loket'),
                      ),
                      SizedBox(height: 36),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password',
                          suffixIcon: Icon(Icons.visibility),
                        ),
                      ),
                      const SizedBox(height: 86.0),
                      AppButton(
                        label: 'Login',
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                        },
                      ),
                      SizedBox(height: 128),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(AssetsConst.logoCWB, height: 40),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
