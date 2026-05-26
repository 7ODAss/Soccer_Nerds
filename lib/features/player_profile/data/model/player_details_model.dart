import '../../../list_of_match/domain/entity/live_match_details.dart';
import '../../domain/entity/player_details.dart';

class PlayerDetailsModel extends PlayerDetails {
  const PlayerDetailsModel({required super.player, required super.stats});

  factory PlayerDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlayerDetailsModel(
        player: PlayerProfileDetailsModel.fromJson(json['player']),
        stats: StatsModel.fromJson(json['statistics'][0]),
      );

  Map<String, dynamic> toJson() => {'player': player, 'statistics': stats};

  factory PlayerDetailsModel.fromDomain(PlayerDetails entity) {
    return PlayerDetailsModel(
      player: PlayerProfileDetailsModel.fromDomain(entity.player),
      stats: StatsModel.fromDomain(entity.stats),
    );
  }
}

class PlayerProfileDetailsModel extends PlayerProfileDetails {
  const PlayerProfileDetailsModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.nationality,
    required super.height,
    required super.weight,
    required super.photo,
  });
  factory PlayerProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlayerProfileDetailsModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'No Name',
        firstName: json['firstname'] ?? '?',
        lastName: json['lastname'] ?? '?',
        age: json['age'] ?? 18,
        nationality: json['nationality'] ?? '?',
        height: json['height'] ?? '?',
        weight: json['weight'] ?? '?',
        photo: json['photo'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'firstname': firstName,
    'lastname': lastName,
    'age': age,
    'nationality': nationality,
    'height': height,
    'weight': weight,
    'photo': photo,
  };

  factory PlayerProfileDetailsModel.fromDomain(PlayerProfileDetails entity) {
    return PlayerProfileDetailsModel(
      id: entity.id,
      name: entity.name,
      firstName: entity.firstName,
      lastName: entity.lastName,
      age: entity.age,
      nationality: entity.nationality,
      height: entity.height,
      weight: entity.weight,
      photo: entity.photo,
    );
  }

}


class StatsModel extends Stats {
  const StatsModel({
    required super.team,
    required super.league,
    required super.games,
    required super.shots,
    required super.goals,
    required super.pass,
    required super.tackles,
    required super.duels,
    required super.penalty,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
    team: Team.fromJson(json['team']),
    league: LeagueModel.fromJson(json['league']),
    games: GamesModel.fromJson(json['games']),
    shots: ShotsModel.fromJson(json['shots']),
    goals: GoalModel.fromJson(json['goals']),
    pass: PassModel.fromJson(json['passes']),
    tackles: TacklesModel.fromJson(json['tackles']),
    duels: DuelsModel.fromJson(json['duels']),
    penalty: PenalityModel.fromJson(json['penalty']),
  );

  Map<String, dynamic> toJson() => {
    'team': team,
    'league': league,
    'games': games,
    'shots': shots,
    'goals': goals,
    'passes': pass,
    'tackles': tackles,
    'duels': duels,
    'penalty': penalty,
  };

  factory StatsModel.fromDomain(Stats entity) {
    return StatsModel(
      team: entity.team,
      league: entity.league,
      games: entity.games,
      shots: entity.shots,
      goals: entity.goals,
      pass: entity.pass,
      tackles: entity.tackles,
      duels: entity.duels,
      penalty: entity.penalty,
    );
  }
}

class LeagueModel extends League {
  const LeagueModel({
    required super.id,
    required super.name,
    required super.country,
    required super.logo,
    required super.season,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? 'No Name',
    country: json['country'] ?? '?',
    logo: json['logo'] ?? '',
    season: json['season'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country': country,
    'logo': logo,
    'season': season,
  };
}

class GamesModel extends Games {
  const GamesModel({
    required super.appearences,
    required super.lineups,
    required super.position,
    required super.rating,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
    appearences: json['appearences'] ?? 0,
    lineups: json['lineups'] ?? 0,
    position: json['position'] ?? 'None',
    rating: json['rating'] ?? '?',
  );

  Map<String, dynamic> toJson() => {
    'appearences': appearences,
    'lineups': lineups,
    'position': position,
    'rating': rating,
  };
}

class ShotsModel extends Shots {
  const ShotsModel({required super.total, required super.on});

  factory ShotsModel.fromJson(Map<String, dynamic> json) =>
      ShotsModel(total: json['total'] ?? 0, on: json['on'] ?? 0);

  Map<String, dynamic> toJson() => {'total': total, 'on': on};
}

class GoalModel extends Goal {
  const GoalModel({required super.total, required super.assist});

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      GoalModel(total: json['total'] ?? 0, assist: json['assists'] ?? 0);

  Map<String, dynamic> toJson() => {'total': total, 'assist': assist};
}

class PassModel extends Pass {
  const PassModel({required super.total, required super.key});

  factory PassModel.fromJson(Map<String, dynamic> json) =>
      PassModel(total: json['total'] ?? 0, key: json['key'] ?? 0);

  Map<String, dynamic> toJson() => {'total': total, 'key': key};
}

class TacklesModel extends Tackles {
  const TacklesModel({required super.total});

  factory TacklesModel.fromJson(Map<String, dynamic> json) =>
      TacklesModel(total: json['total'] ?? 0);

  Map<String, dynamic> toJson() => {'total': total};
}

class DuelsModel extends Duels {
  const DuelsModel({required super.total, required super.won});

  factory DuelsModel.fromJson(Map<String, dynamic> json) =>
      DuelsModel(total: json['total'] ?? 0, won: json['won'] ?? 0);

  Map<String, dynamic> toJson() => {'total': total, 'won': won};
}

class PenalityModel extends Penalty {
  const PenalityModel({required super.scored});

  factory PenalityModel.fromJson(Map<String, dynamic> json) =>
      PenalityModel(scored: json['scored'] ?? 0);

  Map<String, dynamic> toJson() => {'scored': scored};
}

