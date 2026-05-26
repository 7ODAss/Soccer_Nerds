import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/controller/match_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).cardTheme.color;
    return Scaffold(
      body: BlocBuilder<MatchBloc, MatchState>(
        buildWhen:
            (previous, current) =>
                previous.favoriteTeamIds != current.favoriteTeamIds,
        builder: (context, state) {
          final favoriteMatches = state.favoriteTeamIds;

          if (favoriteMatches.isEmpty) {
            return const Center(
              child: Text(
                "You haven't added any favorite teams yet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }


          return ListView.builder(
            itemCount: favoriteMatches.length,
            itemBuilder: (context, index) {
              final call = favoriteMatches[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: color,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Home Team
                      Expanded(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: call.home.logo ?? '',
                              height: 40,
                              errorWidget:
                                  (c, u, e) =>
                                      const Icon(Icons.shield, size: 40),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              call.home.name ?? 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // "VS" Text
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              context.read<MatchBloc>().add(
                                ToggleFavoriteEvent(call),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Away Team
                      Expanded(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: call.away.logo ?? '',
                              height: 40,
                              errorWidget:
                                  (c, u, e) =>
                                      const Icon(Icons.shield, size: 40),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              call.away.name ?? 'N/A',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
