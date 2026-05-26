import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../data/model/live_match_model.dart';
import '../../../controller/match_bloc.dart';

class UpcomingActions extends StatelessWidget {
  final int id;
  final String date;
  final LiveMatchModel match;
  const UpcomingActions({super.key, required this.id, required this.date, required this.match});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocSelector<MatchBloc, MatchState, bool>(
            selector:
                (state) => state.favoriteTeamIds
                .contains(match),
            builder:
                (context, isFavorite) => IconButton(
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons
                    .favorite_border_outlined,
                color:
                isFavorite
                    ? Colors.red
                    : Colors.white,
              ),
              onPressed: () {
                context.read<MatchBloc>().add(
                  ToggleFavoriteEvent(
                    match,
                  ),
                );
              },
            ),
          ),
          Text(
            DateFormat('HH:mm').format(
              DateTime.parse(
                date,
              ).toLocal(),
            ),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
