import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/utils/enums.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/common/custom_appbar.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_bloc.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_state.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/controller/theme_bloc.dart';
import '../component/build_info_row.dart';
import '../component/build_key_stats_section.dart';

class PlayerDetailsScreen extends StatelessWidget {
  const PlayerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileBloc, PlayerProfileState>(
      buildWhen: (previous, current) {
        return previous.playerDetailsState != current.playerDetailsState ||
            previous.playerDetails != current.playerDetails;
      },
      builder: (context, state) {
        switch (state.playerDetailsState) {
          case RequestState.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case RequestState.error:
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error,size: 100,),
                  Text(state.playerDetailsMessage,style: TextStyle(fontSize: 30,color: Colors.white),),
                ],
              ),
            );
          case RequestState.success:
            if (state.playerDetails.isNotEmpty) {
              final details = state.playerDetails.first;
              final player = details.player;
              final stats = details.stats;
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      expandedHeight: 250.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          player.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        background: Hero(
                          tag: 'playerImage_${player.id}',
                          // Ensure this tag matches the one in the list screen for Hero animation
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: player.photo,
                                fit: BoxFit.fill,
                                placeholder:
                                    (context, url) => Shimmer.fromColors(
                                      baseColor: Colors.grey[700]!,
                                      highlightColor: Colors.grey[500]!,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                    ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(
                                  const ChangeThemeEvent(),
                                );
                              },
                              icon: Icon(
                                state.isDark
                                    ? Icons.light_mode_outlined
                                    : Icons.dark_mode_outlined,
                                size: 35,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Overview",
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  BuildInfoRow(
                                    label: "Position:",
                                    value: stats.games.position,
                                  ),

                                  BuildInfoRow(
                                    label: "Team:",
                                    value: stats.team.name,
                                  ),

                                  BuildInfoRow(
                                    label: "League:",
                                    value: stats.league.name,
                                  ),
                                  BuildInfoRow(
                                    label: "Nationality:",
                                    value: player.nationality,
                                  ),

                                  BuildInfoRow(
                                    label: "Age:",
                                    value: player.age.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Height:",
                                    value: player.height,
                                  ),
                                  BuildInfoRow(
                                    label: "Weight:",
                                    value: player.weight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Key Stats ${'(Season ${stats.league.season})'}",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        BuildKeyStatsSection(stats: stats),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attacking Stats",
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  BuildInfoRow(
                                    label: "Goals:",
                                    value: stats.goals.total.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Assists:",
                                    value: stats.goals.assist.toString(),
                                  ),

                                  BuildInfoRow(
                                    label: "Total Shots:",
                                    value: stats.shots.total.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Shots on Target:",
                                    value: stats.shots.on.toString(),
                                  ),

                                  BuildInfoRow(
                                    label: "Penalties Scored:",
                                    value: stats.penalty.scored.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Other Stats",
                                    style:
                                    Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  BuildInfoRow(
                                    label: "lineups:",
                                    value: stats.games.lineups.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Passes:",
                                    value: stats.pass.total.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Tackles:",
                                    value: stats.tackles.total.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Total Duels:",
                                    value: stats.duels.total.toString(),
                                  ),
                                  BuildInfoRow(
                                    label: "Duels Won:",
                                    value: stats.duels.won.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Add more cards for other stats (Passing, Tackles, Duels) if needed
                        const SizedBox(height: 20),
                      ]),
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: CustomAppbar(title: 'Player Details', needBack: true),
                body: const Center(
                  child: Text(
                    'Player details not available.',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
