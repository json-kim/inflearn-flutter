import 'package:flutter/material.dart';
import 'package:image_search/model/photo.dart';

class PhotoBox extends StatelessWidget {
  final Photo photo;
  const PhotoBox({
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        photo.previewURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
