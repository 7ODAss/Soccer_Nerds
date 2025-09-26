import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/ai/presentation/screen/aipreview.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entity/live_match.dart';
import '../../../controller/live_match_details_bloc.dart';
import '../livematch_shared/live_logo_name_team.dart';

class DetailsOfCarousal extends StatelessWidget {
  final LiveMatch match;

  const DetailsOfCarousal({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final progress = (match.fixture.status!.elapsedTime ?? 0) / 90.0;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              LiveLogoNameTeam(
                logo: match.home.logo ?? '',
                name: match.home.name ?? '',
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (progress == 1.0)
                    Text(
                      "Ended",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  if (progress != 1.0)
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: progress > 1.0 ? 1.0 : progress,
                            strokeWidth: 3,
                            backgroundColor: Colors.amber,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              "${match.fixture.status!.elapsedTime.toString() ??
                                  '--'}'",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    '${match.goal.home} - ${match.goal.away}',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<LiveMatchDetailsBloc, LiveMatchDetailsState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LiveMatchDetailsBloc>().add(GetAiMatchPreviewEvent());
                          String? result=state.aiMatchPreview;
                          if(result != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  AiPreview(result: result,)),
                            );
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('data is being processed... please wait!',style: TextStyle(fontSize: 18),),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              )
                            );
                          }
                        },
                        child: Text(
                          'Ai Analyst >>',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(width: 10),
              LiveLogoNameTeam(
                logo: match.away.logo ?? '',
                name: match.away.name ?? '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
