import 'package:equatable/equatable.dart';

class LiveMatch extends Equatable {
  final Fixture fixture;
  final Team home;
  final Team away;
  final Goal goal;

  const LiveMatch({
    required this.fixture,
    required this.home,
    required this.away,
    required this.goal,
  });

  @override
  List<Object?> get props => [fixture, home, away, goal];
}

class Fixture extends Equatable {
  final int id;
  final String date;
  final Status? status;
  final Venue? venue;

  const Fixture({
    required this.id,
    required this.status,
    required this.date,
    required this.venue,
  });

  @override
  List<Object?> get props => [id, date, status, venue];

}

class Venue extends Equatable {
  final int? id;
  final String? name;

  const Venue({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];

}

class Status extends Equatable {
  final int? elapsedTime;
  final String? long;

  const Status({required this.elapsedTime, required this.long});

  @override
  List<Object?> get props => [elapsedTime, long];

}

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? isWinner; //null if it is draw

  const Team({
    required this.name,
    required this.logo,
    this.isWinner,
    required this.id,
  });

  @override
  List<Object?> get props => [name, logo, isWinner, id];

}

class Goal extends Equatable {
  final int home;
  final int away;

  const Goal({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}
