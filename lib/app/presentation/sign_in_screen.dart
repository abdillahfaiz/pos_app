import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/app/core/app_color.dart';
import 'package:pos_app/app/core/components/app_button.dart';
import 'package:pos_app/app/core/string_const/assets_const.dart';
import 'package:pos_app/app/cubit/auth_cubit/auth_cubit.dart';
import 'package:pos_app/app/cubit/auth_cubit/auth_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthCubit(), child: _Content());
  }
}

class _Content extends StatelessWidget {
  _Content();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current.loginResponse != previous.loginResponse ||
              current.error != previous.error,
      listener: (context, state) {
        if (state.loginResponse.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                state.loginResponse.message ?? '',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          Navigator.pushReplacementNamed(context, '/main');
        }

        if (state.error != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error, style: TextStyle(color: Colors.white)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 213,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Image.asset(AssetsConst.logoWhite),
                  ),
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
                          controller: emailController,
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
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Password',
                            suffixIcon: Icon(Icons.visibility),
                          ),
                        ),
                        const SizedBox(height: 86.0),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return CircularProgressIndicator();
                            } else {
                              return SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                  label: 'Login',
                                  onPressed: () async {
                                    await context.read<AuthCubit>().doLogin(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  },
                                ),
                              );
                            }
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
      ),
    );
  }
}
