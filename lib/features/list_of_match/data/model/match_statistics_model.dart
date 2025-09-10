import '../../domain/entity/live_match_details.dart';
import '../../domain/entity/match_statistics.dart';

class MatchStatisticsModel extends MatchStatistics{
  const MatchStatisticsModel({required super.team, required super.statistics});

  factory MatchStatisticsModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsModel(
      team: Team.fromJson(json['team']),
      statistics: List<StatisticsModel>.from(json['statistics'].map((x) => StatisticsModel.fromJson(x))),
    );
  }
}

class StatisticsModel extends Statistics {
  const StatisticsModel({required super.type, required super.value});
  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      type: json['type'],
      value: json['value'],
    );
  }

}