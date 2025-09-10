import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match_details.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/theme/theme_mode.dart';
import '../upcoming_match_shared/upcoming_painting.dart';

class EventIcon extends StatelessWidget {
  final LiveMatchDetails details;
   EventIcon({super.key, required this.details});

  Widget buildTrailing() {
    switch(details.type){
      case 'Goal':
        return const Icon(Icons.sports_soccer, color: Colors.green,size: 30);
      case 'Card':
        return Icon(
          Icons.style,
          color: details.detail == 'Yellow Card' ? Colors.yellowAccent : Colors.red,
            size: 30
        );
      case 'subst':
        return const Icon(Icons.swap_horiz, color: Colors.blue,size: 30);
      default:
        return const Icon(Icons.event, color: Colors.grey,size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizedHeight = MediaQuery.of(context).size.height*0.08;
    return SizedBox(
      height: sizedHeight,
      child: AngledCard(
        color1: Theme.of(context).extension<AngledCardTheme>()!.color1,
        color2: Theme.of(context).extension<AngledCardTheme>()!.color2,
        child: ListTile(
          leading: Text(
            '${details.time.elapsed}\'',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          title: Text(
            '${details.player.name ?? "Team Action"} (${details.team.name})',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          subtitle: Text(
            details.type.toString(),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          trailing: buildTrailing(),
        ),
      ),
    );
  }
}
