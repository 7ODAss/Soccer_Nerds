import 'package:equatable/equatable.dart';


import '../../../list_of_match/domain/entity/live_match_details.dart';

class PlayerDetails extends Equatable{
  final PlayerProfileDetails player;
  final Stats stats;

  const PlayerDetails({
    required this.player,
    required this.stats,
  });
  @override
  List<Object?> get props => [player,stats];
}


class PlayerProfileDetails extends Equatable {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final int age;
  final String nationality;
  final String height;
  final String weight;
  final String photo;


  const PlayerProfileDetails({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.photo,
  });

  @override
  List<Object?> get props => [id, name, firstName, lastName, age, nationality, height, weight, photo];
}


class Stats extends Equatable{
  final Team team;
  final League league;
  final Games games;
  final Shots shots;
  final Goal goals;
  final Pass pass;
  final Tackles tackles;
  final Duels duels;
  final Penalty penalty;

  const Stats({
    required this.team,
    required this.league,
    required this.games,
    required this.shots,
    required this.goals,
    required this.pass,
    required this.tackles,
    required this.duels,
    required this.penalty,
  });
  @override
  List<Object?> get props => [team,league,games,shots,goals,pass,tackles,duels,penalty];
}

class League extends Equatable{
  final int id;
  final String name;
  final String country;
  final String logo;
  final int season;

  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.season,
  });
  @override
  List<Object?> get props => [id,name,country,logo,season];

}

class Games extends Equatable{
  final int appearences;
  final int lineups;
  final String position;
  final String rating;

  const Games({
    required this.appearences,
    required this.lineups,
    required this.position,
    required this.rating,
  });

  @override
  List<Object?> get props => [appearences,lineups,position,rating];
}

class Shots extends Equatable{
  final int total;
  final int on;

  const Shots({
    required this.total,
    required this.on,
  });
  @override
  List<Object?> get props => [total,on];

}

class Goal extends Equatable{
  final int total;
  final int assist;

  const Goal({
    required this.total,
    required this.assist,
  });
  @override
  List<Object?> get props => [total,assist];
}

class Pass extends Equatable{
  final int total;
  final int key;

  const Pass({
    required this.total,
    required this.key,
  });
  @override
  List<Object?> get props => [total,key];

}

class Tackles extends Equatable{
  final int total;

  const Tackles({
    required this.total,
  });
  @override
  List<Object?> get props => [total];
}

class Duels extends Equatable{
  final int total;
  final int won;
  const Duels({
    required this.total,
    required this.won,
  });
  @override
  List<Object?> get props => [total,won];

}

class Penalty extends Equatable{
  final int scored;

  const Penalty({
    required this.scored,
  });
  @override
  List<Object?> get props => [scored];

}