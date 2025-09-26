import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/services/service_locator.dart';
import '../../../controller/live_match_details_bloc.dart';
import '../../../screen/live_match_details_screen.dart';

class LiveAction extends StatelessWidget {
  final LiveMatch match;
  const LiveAction({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                create:
                    (context) =>
                getIt<LiveMatchDetailsBloc>()
                  ..add(
                    GetLiveMatchDetailsEvent(
                      id: match.fixture.id,
                      //592872
                    ),
                  )
                  ..add(
                    GetTeamFormEvent(
                      id: match.fixture.id,
                    ),
                  )
                  ..add(
                    GetMatchStatisticsEvent(
                      id: match.fixture.id,
                    ),
                  ),
                child: LiveMatchDetailsScreen(
                  match: match,
                ),
              ),
            ),
          );
        },
        child: Text(
          'Details >>',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
