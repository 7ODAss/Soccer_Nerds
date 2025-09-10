import 'package:football_app/features/leagues/domain/entity/standing_league.dart';

class LeagueModel extends League{
  const LeagueModel({required super.id, required super.name, required super.season});

  factory LeagueModel.fromJson(Map<String,dynamic> json){
    return LeagueModel(
      id: json['league']['id'],
      name: json['league']['name'],
      season: json['seasons'][0]['year'],
    );
  }

}