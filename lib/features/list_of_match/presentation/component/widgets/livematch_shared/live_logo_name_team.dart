import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LiveLogoNameTeam extends StatelessWidget {
  final String logo;
  final String name;

  const LiveLogoNameTeam({super.key, required this.logo, required this.name});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: logo ?? '',
            placeholder: (context, url) =>
            const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) =>
            const Icon(Icons.shield),
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
