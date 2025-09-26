import 'package:flutter/material.dart';

import '../../domain/entity/player_details.dart';
import 'build_stats_item.dart';

class BuildKeyStatsSection extends StatelessWidget {
  final Stats stats;
  const BuildKeyStatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    List<Widget> keyStats = [];
    keyStats.add(
      BuildStatsItem(
        icon: Icons.event_available,
        value: stats.games.appearences.toString(),
        label: "Played",
      ),
    );
    keyStats.add(
      BuildStatsItem(
        icon: Icons.sports_soccer,
        value: stats.goals.total.toString(),
        label: "Goals",
      ),
    );
    keyStats.add(
      BuildStatsItem(
        icon: Icons.assistant,
        value: stats.goals.assist.toString(),
        label: "Assists",
      ),
    );
    keyStats.add(
      BuildStatsItem(
        icon: Icons.star_rate,
        value: stats.games.rating.length > 3 ? stats.games.rating.substring(0, 3) : stats.games.rating,
        label: "Rating",
      ),
    );
    if (keyStats.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 16.0,
        runSpacing: 16.0,
        children: keyStats,
      ),
    );
  }
}
