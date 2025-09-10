import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_action.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_carousal_details.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_information.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_logo_name_team.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_background.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_shared/live_status.dart';
import 'package:football_app/features/list_of_match/presentation/screen/live_match_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/enums.dart';
import '../controller/live_match_details_bloc.dart';
import '../controller/match_bloc.dart';

class LiveMatchComponent extends StatelessWidget {
  const LiveMatchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    print("live match");
    final carouselHeight = MediaQuery.of(context).size.height * 0.25;
    return BlocBuilder<MatchBloc, MatchState>(
      buildWhen:
          (previous, current) =>
              previous.liveMatch != current.liveMatch ||
              previous.liveMatchState != current.liveMatchState,
      builder: (context, state) {
        switch (state.liveMatchState) {
          case RequestState.loading:
            return SizedBox(
              height: carouselHeight,
              child: Center(child: CircularProgressIndicator()),
            );

          case RequestState.error:
            return Center(
              child: Column(
                children: [
                  Icon(Icons.error, size: 100),
                  Text(state.liveMatchMessage, style: TextStyle(fontSize: 25)),
                ],
              ),
            );
          case RequestState.success:
            if (state.liveMatch.isEmpty) {
              return SizedBox(
                height: carouselHeight,
                child: Center(
                  child: Text(
                    'No live matches today',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              );
            }
            return SizedBox(
              height: carouselHeight,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: carouselHeight,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                ),
                itemCount: state.liveMatch.length,
                itemBuilder: (context, index, realIndex) {
                  final match = state.liveMatch[index];
                  final progress = (match.fixture.status!.elapsedTime ?? 0) / 90.0;
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        elevation: 4.0,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            LiveBackground(),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            LiveCarousalDetails(match: match,progress: progress,),
                          ],
                        ),
                      ),
                      LiveAction(match: match,),
                    ],
                  );
                },
              ),
            );
        }
      },
    );
  }
}
