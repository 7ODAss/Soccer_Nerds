import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveStatus extends StatelessWidget {
  final double progress;
  final int homeGoals,awayGoals,elapsedTime;
  const LiveStatus({super.key, required this.progress, required this.homeGoals, required this.awayGoals, required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    final isExtraTime = elapsedTime > 90;
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        if (progress == 1.0)
          Text(
            "Ended",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        if (progress != 1.0)
          SizedBox(
            height: 40,
            width: 40,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress > 1.0 ? 1.0 : progress,
                  strokeWidth: 3,
                  backgroundColor:  isExtraTime ? Colors.red : Colors.amber,
                  valueColor:
                  const AlwaysStoppedAnimation<Color> (Colors.white),
                ),
                Center(
                  child: Text( isExtraTime ? "ET${elapsedTime - 90}}'" : "${elapsedTime.toString()}'",
                    style: GoogleFonts.lato(
                      textStyle:
                      const TextStyle(
                        color:
                        Colors
                            .white,
                        fontWeight:
                        FontWeight
                            .bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 4),
        Text(
          '$homeGoals - $awayGoals',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ],
    );
  }
}
