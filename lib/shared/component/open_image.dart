import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/problem_model.dart';


class OpenImageScreen extends StatelessWidget {
  const OpenImageScreen({super.key, this.imageUrl, this.isImageAfter = false});
  final MAProblemModel? imageUrl;
  final bool isImageAfter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl:
                  isImageAfter ? imageUrl!.imageAfterUrl : imageUrl!.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
