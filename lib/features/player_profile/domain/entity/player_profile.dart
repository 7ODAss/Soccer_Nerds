import 'package:equatable/equatable.dart';

class Standing extends Equatable {
  final int rank;
  final String teamName;
  final String teamLogo;
  final int points;
  final int played;

  const Standing({
    required this.rank,
    required this.teamName,
    required this.teamLogo,
    required this.points,
    required this.played,
  });

  @override
  List<Object?> get props => [rank, teamName, teamLogo, points, played];
}


class League extends Equatable {
  final int id;
  final String name;
  final int season;

  const League({required this.id, required this.name, required this.season});

  @override
  List<Object?> get props => [id, name, season];
}
