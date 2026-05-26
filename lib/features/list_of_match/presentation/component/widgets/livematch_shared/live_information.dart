import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveInformation extends StatelessWidget {
  final String? stadium,timeLong;
  const LiveInformation({super.key, required this.stadium, required this.timeLong});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            stadium ?? 'N/A',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.white,
          ),
          child: Text(
            timeLong ??
                'Scheduled',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
