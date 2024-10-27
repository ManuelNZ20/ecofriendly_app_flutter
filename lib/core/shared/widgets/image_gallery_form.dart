import 'dart:io';
import 'package:flutter/material.dart';
import 'circular_progress_container_image.dart';

class ImageGalleryForm extends StatelessWidget {
  const ImageGalleryForm({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    if (imgUrl.isEmpty) {
      return Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const CircularProgressContainer();
          }
          return child;
        },
      );
    }
    late ImageProvider imgProvider;
    if (imgUrl.startsWith('http') || imgUrl.startsWith('https')) {
      imgProvider = NetworkImage(imgUrl);
    } else {
      imgProvider = FileImage(File(imgUrl));
    }
    return FadeInImage(
      placeholder: const NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif'),
      image: imgProvider,
    );
  }
}
