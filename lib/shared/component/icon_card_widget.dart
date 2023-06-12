
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

class IconCardGetImageWidget extends StatelessWidget {
  const IconCardGetImageWidget({
    super.key,
    this.onTap,
    this.color = kDprimaryColor,
    this.onDelete,
    this.image,
    this.isSelectedImage = false,
  });

  final Function()? onTap;
  final Function()? onDelete;
  final bool? isSelectedImage;
  final File? image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (!isSelectedImage!) {
      return Hero(
        tag: 'sl_button',
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 1.0,
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 60.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      "اضف صوره",
                      style: GoogleFonts.almarai(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Hero(
        tag: 'sl_button',
        child: SizedBox(
          height: 220,
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: image != null
                          ? FileImage(image!)
                          : Image.asset('images/splash.png').image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: kDprimaryColor,
                    child: IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

