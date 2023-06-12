import 'package:flutter/material.dart';

class Skeliton extends StatelessWidget {
  const Skeliton({super.key,  this.width, required this.height});
final double? width ,height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.20),
        borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}