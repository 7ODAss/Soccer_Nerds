import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/core/utils/enums.dart';
import 'package:football_app/features/player_profile/presentation/screen/player_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/player_profile_bloc.dart';
import '../controller/player_profile_event.dart';
import '../controller/player_profile_state.dart';

class PlayerProfileScreen extends StatelessWidget {
  final PageController pageController = PageController();

  PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).cardTheme.color;
    debugPrint("player profile");
    return BlocBuilder<PlayerProfileBloc, PlayerProfileState>(
      buildWhen: (previous, current) {
        return previous.playerProfile != current.playerProfile ||
            previous.playerProfileState != current.playerProfileState;
      },
      builder: (context, state) {
        switch (state.playerProfileState) {
          case RequestState.loading:
            return SizedBox(
              height: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            );
          case RequestState.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 100),
                  Text(
                    state.playerProfileMessage,
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PlayerProfileBloc>().add(
                        GetPlayerProfileEvent(state.pageIndex),
                      );
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          case RequestState.success:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        color: Colors.transparent,
                        dotBorder: DotBorder(color: Colors.grey,width: 2),
                        width: 35,
                        height: 8,
                        rotationAngle: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        verticalOffset: 25
                      ),
                      activeDotDecoration: DotDecoration(
                        color: Theme.of(context).cardTheme.color!,
                        width: 25,
                        height: 25,
                        rotationAngle: 45,
                        verticalOffset: 25,
                        dotBorder: DotBorder(width: 3,color: Colors.orange.shade800)
                      ),
                    ),
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: 3,
                    onPageChanged: (index) {
                      context.read<PlayerProfileBloc>().add(
                        GetPlayerProfileEvent(index + 1),
                      );
                      context.read<PlayerProfileBloc>().add(
                        ChangeScreenEvent(index + 1),
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final player = state.playerProfile[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                context.read<PlayerProfileBloc>().add(
                                  GetPlayerDetailsEvent(player.id),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PlayerDetailsScreen(),
                                  ),
                                );
                              },
                              child: Card(
                                color: color,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                  height: 270,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                player.name,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Age : ${player.age.toString()}',
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Region : ${player.nationality}',
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Position : ${player.position}',
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Num : ${player.number.toString()}',
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 3,
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Expanded(
                                          child: Hero(
                                            tag: 'playerImage_${player.id}',
                                            child: CachedNetworkImage(
                                              imageUrl: player.photo,
                                              placeholder:
                                                  (context, url) =>
                                                      Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey,
                                                        highlightColor:
                                                            Colors.white,
                                                        child: Container(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (context, index) => Divider(
                              thickness: 3,
                              indent: 20,
                              endIndent: 20,
                            ),
                        itemCount: state.playerProfile.length,
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
