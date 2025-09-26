import 'package:football_app/features/list_of_match/domain/entity/team_form.dart';
import 'live_match_model.dart';

class TeamFormModel extends TeamForm {
  const TeamFormModel({
    required super.team,
    required super.mainPlayers,
    required super.substitutes,
    super.formation,
  });

  factory TeamFormModel.fromJson(Map<String, dynamic> json) {
    return TeamFormModel(
      team: TeamModel.fromJson(json['team']),
      mainPlayers: List<PlayerModel>.from((json['startXI'] as List).map((p) => PlayerModel.fromJson(p))),
      substitutes: List<PlayerModel>.from((json['substitutes'] as List).map((x) => PlayerModel.fromJson(x))),
      formation: json['formation'],
    );
  }
}

class PlayerModel extends PlayerTeam {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.number,
    required super.position,
  });
  factory PlayerModel.fromJson(Map<String,dynamic>json)=>PlayerModel(
    id: json['player']['id'] ?? 0,
    name: json['player']['name'] ?? 'N/A',
    number: json['player']['number'],
    position: json['player']['pos'] ?? '??',
  );
}
