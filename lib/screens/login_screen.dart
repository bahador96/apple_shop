import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextController = TextEditingController(text: "ben");
  final _passwordTextController = TextEditingController(text: "1234567");

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.blue,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon_application.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "اپل شاپ",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "sb",
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameTextController,
                      decoration: InputDecoration(
                        labelText: " نام کاربری",
                        labelStyle: const TextStyle(
                          fontFamily: "sm",
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: CustomColors.blue,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "رمز عبور",
                        labelStyle: const TextStyle(
                          fontFamily: 'sm',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: CustomColors.blue,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitiateState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontFamily: 'sb',
                                fontSize: 18,
                              ),
                              maximumSize: const Size(200, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginRequest(
                                  _usernameTextController.text,
                                  _passwordTextController.text,
                                ),
                              );
                            },
                            child: const Text("ورود به حساب کاربری"),
                          );
                        }

                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        }

                        if (state is AuthResponseState) {
                          Text widget = const Text("");
                          state.response.fold((l) {
                            widget = Text(l);
                          }, (r) {
                            widget = Text(r);
                          });

                          return widget;
                        }

                        return const Text('خطای نا مشخص');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
