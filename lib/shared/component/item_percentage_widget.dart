import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPercentageWedget extends StatelessWidget {
  const ItemPercentageWedget(
      {super.key, required this.text1, required this.text2,});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                text1,
                style: GoogleFonts.almarai(
                    // color: kDprimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text2,
              style: GoogleFonts.almarai(
                // color: kDprimaryColor,
                fontSize: 16,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
