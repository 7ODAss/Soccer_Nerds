import 'dart:async'; // For Timer (debouncer)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/player_profile/data/model/player_profile_model.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_bloc.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_state.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../player_profile/presentation/controller/player_profile_event.dart';
import '../../../../../player_profile/presentation/screen/player_details_screen.dart';


class CustomSearchDelegate extends SearchDelegate<PlayerProfileModel> {
  Timer? _debouncer;

  CustomSearchDelegate();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        shape: Border.all(color: Colors.transparent),
        backgroundColor: theme.appBarTheme.backgroundColor, // Or your desired color
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white), // Adjust icon color if needed
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(color: Colors.white), // Adjust text color if needed
        toolbarTextStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.white), // Adjust text color if needed
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white70,fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
       Navigator.pop(context); // Pass null as no result is selected
      },
    );
  }

  void _performSearch(BuildContext context, String currentQuery) {
    if (currentQuery.trim().isNotEmpty) {
      context.read<PlayerProfileBloc>().add(GetPlayerProfileSearchEvent(currentQuery.trim()));
    }
  }


  @override
  void showSuggestions(BuildContext context) {
    super.showSuggestions(context); // Important to call super
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        _performSearch(context, query);
      }
    });
  }


  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isNotEmpty) {
      _performSearch(context, query);
    } else {
      return const Center(
        child: Text("Please enter a search term."),
      );
    }

    return BlocBuilder<PlayerProfileBloc, PlayerProfileState>(
      builder: (context, state) {
        switch (state.playerProfileSearchState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
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
            if (state.playerProfileSearch.isEmpty) {
              return Center(child: Text('No results found for "$query"'));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: state.playerProfileSearch.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                itemBuilder: (context, index) {
                  final result = state.playerProfileSearch[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(result.name,style: TextStyle(fontSize: 20,color: Colors.white),), // Example: Display match name
                      subtitle: Text(result.nationality,style: TextStyle(fontSize: 17,color: Colors.white)),
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(result.photo),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                      onTap: () {
                        context.read<PlayerProfileBloc>().add(GetPlayerDetailsEvent(result.id));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PlayerDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 8),
            Text('Search for players...'),
          ],
        ),
      );
    }

    return BlocBuilder<PlayerProfileBloc, PlayerProfileState>(
      builder: (context, state) {
        switch (state.playerProfileSearchState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
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
            if (state.playerProfileSearch.isEmpty) {
              return Center(child: Text('No results found for "$query"'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: state.playerProfileSearch.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                itemBuilder: (context, index) {
                  final result = state.playerProfileSearch[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(result.name,style: TextStyle(fontSize: 20,color: Colors.white),), // Example: Display match name
                      subtitle: Text(result.nationality,style: TextStyle(fontSize: 17,color: Colors.white)),
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(result.photo),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                      onTap: () {
                        context.read<PlayerProfileBloc>().add(GetPlayerDetailsEvent(result.id));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PlayerDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }
}
