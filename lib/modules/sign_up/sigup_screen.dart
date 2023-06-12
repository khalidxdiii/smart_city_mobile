import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'signup_screen_module.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const Scaffold(
        body: SignupscreenModule()
      ),
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
                        child: const SignupscreenModule()),
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
