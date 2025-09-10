import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/theme/theme_mode.dart';
import 'package:football_app/core/utils/enums.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/common/custom_appbar.dart';
import 'package:football_app/features/list_of_match/presentation/controller/live_match_details_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/screen/statistics_screen.dart';
import 'package:football_app/features/list_of_match/presentation/screen/team_form_screen.dart';
import '../component/livematch_details_component.dart';
import '../component/widgets/livematch_details_shared/details_of_carousal.dart';
import '../component/widgets/livematch_details_shared/live_details_background.dart';

class LiveMatchDetailsScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final LiveMatch match;

  LiveMatchDetailsScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Match Details', needBack: true),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 4.0,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LiveDetailsBackground(),
                  DetailsOfCarousal(match: match),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //final team = state.teamForm;
          Expanded(
            child: BlocBuilder<LiveMatchDetailsBloc, LiveMatchDetailsState>(
              builder: (context, state) {
                final List<Widget> pages;
                final List<String> title;
                if (state.teamFormState == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.teamFormState == RequestState.error) {
                  return Center(child: Text(state.teamFormMessage));
                }
                if (state.teamForm.length < 2) {
                  title = ['Events', 'Stats', 'Teams'];
                  pages = [
                    LiveMatchDetailsComponent(),
                    StatisticsScreen(match: match),
                    const Center(
                      child: Text(
                        "TeamForms data not available for this match.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ];
                } else {
                  title = ['Events', 'Stats', 'Home', 'Away'];
                  pages = [
                    LiveMatchDetailsComponent(),
                    StatisticsScreen(match: match),
                    TeamFormScreen(lineup: state.teamForm[0]), // Home Team
                    TeamFormScreen(lineup: state.teamForm[1]), // Away Team
                  ];
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pages.length, (index) {
                        bool isSelected = index == state.index;
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 50,
                              width: 70,
                              decoration: BoxDecoration(
                                //color: isSelected ? Colors.orange : Colors.grey[300],
                                color:
                                    isSelected
                                        ? Theme.of(
                                          context,
                                        ).extension<AngledCardTheme>()!.color2
                                        : Theme.of(
                                          context,
                                        ).extension<AngledCardTheme>()!.color1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                title[index],
                                style: TextStyle(
                                   color: isSelected ? Colors.white : Colors.grey[300],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 10),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: pages,
                        onPageChanged: (index) {
                          context.read<LiveMatchDetailsBloc>().add(
                            ChangeScreenEvent(index),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
