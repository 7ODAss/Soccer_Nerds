import '../../domain/entity/live_match.dart';

class LiveMatchModel extends LiveMatch {
  const LiveMatchModel({
    required super.fixture,
    required super.home,
    required super.away,
    required super.goal,
  });

  factory LiveMatchModel.fromJson(Map<String, dynamic> json) => LiveMatchModel(
    fixture: FixtureModel.fromJson(json['fixture']),
    home: TeamModel.fromJson(json['teams']['home']),
    away: TeamModel.fromJson(json['teams']['away']),
    goal: GoalModel.fromJson(json['goals']),
  );

  Map<String, dynamic> toJson() => {
    'fixture': fixture,
    'teams': {'home': home, 'away': away},
    'goals': goal,
  };

  factory LiveMatchModel.fromDomain(LiveMatch entity) {
    return LiveMatchModel(
      fixture: FixtureModel.fromDomain(entity.fixture),
      home: TeamModel.fromDomain(entity.home),
      away: TeamModel.fromDomain(entity.away),
      goal: GoalModel.fromDomain(entity.goal),
    );
  }
}

class FixtureModel extends Fixture{
  const FixtureModel({
    required super.id,
    required super.date,
    required super.status,
    required super.venue,
  });
  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      id: json['id'],
      status: json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      date: json['date'],
      venue: json['venue'] != null ? VenueModel.fromJson(json['venue']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'date': date,
    'venue': venue,
  };

  factory FixtureModel.fromDomain(Fixture entity) {
    return FixtureModel(
      id: entity.id,
      status: StatusModel.fromDomain(entity.status!),
      date: entity.date,
      venue: entity.venue,
    );
  }
}

class VenueModel extends Venue{
  const VenueModel({
    required super.name,
    required super.id,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(name: json['name'] ?? "UnKnown Stadium", id: json['id']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory VenueModel.fromDomain(Venue entity) {
    return VenueModel(name: entity.name, id: entity.id);
  }
}

class StatusModel extends Status{
  const StatusModel({
    required super.elapsedTime,
    required super.long,
  });
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(elapsedTime: json['elapsed'], long: json['long']);
  }

  Map<String, dynamic> toJson() => {'elapsed': elapsedTime, 'long': long};

  factory StatusModel.fromDomain(Status entity) {
    return StatusModel(
      long: entity.long,
      elapsedTime: entity.elapsedTime,
    );
  }
}

class TeamModel extends Team{
  const TeamModel({
    required super.name,
    required super.logo,
    required super.isWinner,
    required super.id,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      name: json['name'] ?? 'UnKnown Team',
      logo: json['logo'] ?? '',
      isWinner: json['winner'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'logo': logo,
    'winner': isWinner,
    'id': id,
  };

  factory TeamModel.fromDomain(Team entity) {
    return TeamModel(
      name: entity.name,
      logo: entity.logo,
      isWinner: entity.isWinner,
      id: entity.id,
    );
  }
}

class GoalModel extends Goal{
  const GoalModel({
    required super.home,
    required super.away,
  });
  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    home: json['home'] ?? 0,
    away: json['away'] ?? 0,
  );
  Map<String, dynamic> toJson() => {'home': home, 'away': away};
  factory GoalModel.fromDomain(Goal entity) {
    return GoalModel(home: entity.home, away: entity.away);
  }
}


