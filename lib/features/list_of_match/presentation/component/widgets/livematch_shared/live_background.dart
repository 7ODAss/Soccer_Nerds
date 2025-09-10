import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LiveBackground extends StatelessWidget {
  const LiveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
      'https://play-lh.googleusercontent.com/fSLe25GAMtXauJhBJxO0TrN_oX7AdmNqsrz9VPdmtwYCqvbP4M9VtN0VzJV0ABDhsBo',
      fit: BoxFit.fill,
      placeholder:
          (context, url) =>
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(color: Colors.black),
          ),
      errorWidget:
          (context, url, error) =>
          Container(color: Colors.grey.shade800),
    );
  }
}
