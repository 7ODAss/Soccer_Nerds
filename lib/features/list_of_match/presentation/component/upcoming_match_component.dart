import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/upcoming_match_shared/upcoming_actions.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/upcoming_match_shared/upcoming_logo_name_team_left.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/upcoming_match_shared/upcoming_logo_name_team_right.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/upcoming_match_shared/upcoming_painting.dart';
import 'package:football_app/features/list_of_match/presentation/controller/match_bloc.dart';
import '../../../../core/theme/controller/theme_bloc.dart';
import '../../../../core/theme/theme_mode.dart';
import '../../../../core/utils/enums.dart';

class UpcomingMatchComponent extends StatelessWidget {
   UpcomingMatchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    print("upcoming match ");
    return BlocBuilder<MatchBloc, MatchState>(
      buildWhen: (previous, current) =>
          previous.upcomingMatchState != current.upcomingMatchState,
      builder: (context, state) {
        switch (state.upcomingMatchState) {
          case RequestState.loading:
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          case RequestState.error:
            return Center(
              child: Column(
                children: [
                  Icon(Icons.error, size: 100),
                  Text(
                    state.upcomingMatchMessage,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            );
          case RequestState.success:
            if (state.upcomingMatch.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text(
                    'No upcoming matches',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final match = state.upcomingMatch[index];
                  final color1 = Theme.of(context).extension<
                      AngledCardTheme>()!.color1;
                  final color2 = Theme.of(context).extension<
                      AngledCardTheme>()!.color2;
                  return SizedBox(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AngledCard(
                        color1: color1,
                        color2: color2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              UpcomingLogoNameTeamLeft(
                                logo: match.home.logo,
                                name: match.home.name,
                              ),
                              UpcomingActions(id: match.fixture.id,
                                date: match.fixture.date,match: state.upcomingMatch[index],),
                              UpcomingLogoNameTeamRight(
                                logo: match.away.logo,
                                name: match.away.name,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
                itemCount: min(state.upcomingMatch.length, 15),
              ),
            );
        }
      },
    );
  }
}

