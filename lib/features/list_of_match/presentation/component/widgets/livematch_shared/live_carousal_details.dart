import 'package:flutter/material.dart';

import '../../../../domain/entity/live_match.dart';
import 'live_information.dart';
import 'live_logo_name_team.dart';
import 'live_status.dart';

class LiveCarousalDetails extends StatelessWidget {
  final LiveMatch match;
  final double progress;
  const LiveCarousalDetails({super.key, required this.match, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          LiveInformation(
            stadium: match.fixture.venue!.name,
            timeLong: match.fixture.status!.long,
          ),
          Expanded(
            child: Row(
              children: [
                LiveLogoNameTeam(
                  logo: match.home.logo ?? '',
                  name: match.home.name ?? '',
                ),
                const SizedBox(width: 10),
                LiveStatus(
                  progress: progress,
                  elapsedTime:
                  match
                      .fixture
                      .status!
                      .elapsedTime!,
                  homeGoals: match.goal.home,
                  awayGoals: match.goal.away,
                ),
                const SizedBox(width: 10),
                LiveLogoNameTeam(
                  logo: match.away.logo ?? '',
                  name: match.away.name ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
