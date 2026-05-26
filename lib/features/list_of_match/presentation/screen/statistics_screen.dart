import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/theme/theme_mode.dart';
import 'package:football_app/core/utils/enums.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match.dart';
import 'package:football_app/features/list_of_match/presentation/controller/live_match_details_bloc.dart';

class StatisticsScreen extends StatelessWidget {
  final LiveMatch match;

   const StatisticsScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMatchDetailsBloc, LiveMatchDetailsState>(
      buildWhen:
          (previous, current) =>
              previous.statisticsState != current.statisticsState,
      builder: (context, state) {
        switch (state.statisticsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.error:
            return Center(child: Text(state.statisticsMessage));
          case RequestState.success:
            if (state.statistics.length < 2) {
              return const Center(
                child: Text(
                  "Statistics are not available for this match.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              );
            }

            final homeStats = state.statistics[0];
            final awayStats = state.statistics[1];

            return ListView.separated(
              itemBuilder: (context, index) {
                final homeValue = homeStats.statistics[index].value;
                final awayValue = awayStats.statistics[index].value;

                final homeRatio = homeValue is String ? int.tryParse(homeValue.replaceAll('%', '',),) : homeValue;
                final awayRatio = awayValue is String ? int.tryParse(awayValue.replaceAll('%', '',),) : awayValue;

                final color3 = Theme.of(context).extension<AngledCardTheme>()!.color3;
                final color2 = Theme.of(context).extension<AngledCardTheme>()!.color2;

                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              homeValue == null ? '0' : homeValue.toString(),
                              style: TextStyle(
                                color: color3,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              homeStats.statistics[index].type,
                              style: TextStyle(
                                color: color3,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              awayValue == null ? '0' : awayValue.toString(),
                              style: TextStyle(
                                color: color2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 15,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: homeRatio == null ? 0 : homeRatio ?? 0, child: Container(color:color3),
                                      ),
                                      Expanded(
                                        flex: awayRatio == null ? 0 : awayRatio ?? 0,child: Container(color: color2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: homeStats.statistics.length,
            );
        }
      },
    );
  }
}

