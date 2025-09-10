import '../../domain/entity/standing_league.dart';

class StandingModel extends Standing {
  const StandingModel({
    required super.rank,
    required super.teamName,
    required super.teamLogo,
    required super.points,
    required super.played,
  });

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    // FIX: Safely access the nested 'team' and 'all' objects.
    final teamData = json['team'] as Map<String, dynamic>?;
    final allData = json['all'] as Map<String, dynamic>?;

    return StandingModel(
      rank: json['rank'] ?? 0,
      // Use the safe teamData object. If it's null, provide default values.
      teamName: teamData?['name'] ?? 'Unknown Team',
      teamLogo: teamData?['logo'] ?? '',
      points: json['points'] ?? 0,
      // Use the safe allData object.
      played: allData?['played'] ?? 0,
    );
  }
}