import '../../domain/entity/live_match_details.dart';

class LiveMatchDetailsModel extends LiveMatchDetails {
  const LiveMatchDetailsModel({
    required super.time,
    required super.team,
    required super.player,
    required super.assist,
    required super.type,
    required super.detail,
  });
  factory LiveMatchDetailsModel.fromJson(Map<String, dynamic> json) {
    return LiveMatchDetailsModel(
      time: Time.fromJson(json['time']),
      team: Team.fromJson(json['team']),
      player: Player.fromJson(json['player']),
      assist: Assist.fromJson( json['assist']),
      type: json['type'],
      detail: json['detail'],
    );
  }
}
