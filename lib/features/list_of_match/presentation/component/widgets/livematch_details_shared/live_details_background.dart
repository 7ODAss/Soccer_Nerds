import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LiveDetailsBackground extends StatelessWidget {
  const LiveDetailsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
      'https://t3.ftcdn.net/jpg/05/94/78/88/360_F_594788841_ggzsjDIDjBqV2LYMNBBEglPN1VR0WVLF.jpg',
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Shimmer.fromColors(
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
