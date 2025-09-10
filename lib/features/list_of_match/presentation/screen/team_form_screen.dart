import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/domain/entity/team_form.dart';
import 'package:football_app/features/list_of_match/presentation/controller/live_match_details_bloc.dart';

import '../../../../core/theme/theme_mode.dart';

class TeamFormScreen extends StatelessWidget {
  final TeamForm lineup;

   TeamFormScreen({super.key, required this.lineup});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMatchDetailsBloc, LiveMatchDetailsState>(
      builder: (context, state) {
        List<String> category = ['MainPlayers', 'Substitutes'];
        int categoryIndex = state.teamIndex;
        final color1 = Theme.of(context).extension<AngledCardTheme>()!.color1;
        final color2 = Theme.of(context).extension<AngledCardTheme>()!.color2;

        return Column(
          children: [
            Text(lineup.team.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Row(
              children: List.generate(category.length, (index) {
                bool isSelected = index == categoryIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<LiveMatchDetailsBloc>().add(
                        ChangeTeamEvent(index),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          color: isSelected ? color2 : color1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[300],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: IndexedStack(
                index: categoryIndex,
                children: [
                  _buildPlayersList(lineup.mainPlayers, true),
                  _buildPlayersList(lineup.substitutes, false),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildPlayersList(List<Player> players, bool isStartingXI) {
    if (players.isEmpty) {
      return Center(
        child: Text(
          'No ${isStartingXI ? 'starting players' : 'substitutes'} available',
          style: TextStyle(fontSize: 16, color: Colors.grey[300]),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: players.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final player = players[index];
        return _PlayerCard(player: player, isStartingXI: isStartingXI);
      },
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final Player player;
  final bool isStartingXI;

  const _PlayerCard({required this.player, required this.isStartingXI});

  @override
  Widget build(BuildContext context) {
    final color1 = Theme.of(context).extension<AngledCardTheme>()!.color1;
    final color2 = Theme.of(context).extension<AngledCardTheme>()!.color2;
    final color3 = Theme.of(context).extension<AngledCardTheme>()!.color3;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color2,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                isStartingXI
                    ? color3
                    : Colors.grey,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            player.number?.toString() ?? '-',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white ,
            ),
          ),
        ),
        title: Text(
          player.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            player.position ?? 'N/A',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
