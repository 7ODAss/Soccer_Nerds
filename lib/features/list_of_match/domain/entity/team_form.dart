import 'package:equatable/equatable.dart';

import 'live_match.dart';


class TeamForm extends Equatable{
  final Team team; //Team class from live match entity
  final List<PlayerTeam>mainPlayers;
  final List<PlayerTeam>substitutes;
  final String? formation;

  const TeamForm({
    required this.team,
    required this.mainPlayers,
    required this.substitutes,
    this.formation,
  });

  @override
  List<Object?> get props => [team, mainPlayers, substitutes,formation];
}


class PlayerTeam extends Equatable{
  final int id;
  final String name;
  final int number;
  final String position;

  const PlayerTeam({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
  });
  @override
  List<Object?> get props => [id, name, number, position];
}