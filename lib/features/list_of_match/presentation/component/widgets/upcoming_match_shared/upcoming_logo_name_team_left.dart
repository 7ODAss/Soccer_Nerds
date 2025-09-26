import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingLogoNameTeamLeft extends StatelessWidget {
  final String logo;
  final String name;

  const UpcomingLogoNameTeamLeft({
    super.key,
    required this.logo,
    required this.name,

  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CachedNetworkImage(
            imageUrl: logo,
            width: 60,
            height: 60,
            errorWidget: (context, url, error) => Icon(Icons.shield, size: 30),
          ),

        ],
      ),
    );
  }
}
