import 'dart:io';

import 'package:flutter/material.dart';

class ImageGalleryFormAvatar extends StatelessWidget {
  const ImageGalleryFormAvatar({
    super.key,
    required this.img,
    required this.onPressed,
  });
  final String img;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 150,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 150,
            child: img.isEmpty
                ? const AvatarImageNotFound()
                : ImageAvatar(
                    imgUrl: img,
                  ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton.filled(
              onPressed: onPressed,
              icon: const Icon(Icons.image_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    super.key,
    required this.imgUrl,
  });
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    late ImageProvider imgProvider;
    if (imgUrl.startsWith('http') || imgUrl.startsWith('https')) {
      imgProvider = NetworkImage(imgUrl);
    } else {
      imgProvider = FileImage(File(imgUrl));
    }
    return FadeInImage(
      placeholder: const NetworkImage(
        'https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif',
      ),
      image: imgProvider,
    );
  }
}

class AvatarImageNotFound extends StatelessWidget {
  const AvatarImageNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        );
    return Center(
      child: Text(
        'Image not found',
        style: textStyle,
      ),
    );
  }
}
