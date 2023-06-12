import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'user_layout_screen_module.dart';


class UserLayoutScreen extends StatelessWidget {
  const UserLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const Scaffold(
        body: UserLayoutScreenModule(),
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
                    width: 600,
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
                        child: const UserLayoutScreenModule()),
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
