import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'login_screen_module.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const LoginScreenModule(),
      desktop: Scaffold(
        body: Stack(children: [
          Container(color: Colors.grey[300]),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    width: 500,
                    //height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: const LoginScreenModule(),),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
