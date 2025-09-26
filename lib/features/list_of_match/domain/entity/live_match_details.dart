import 'package:equatable/equatable.dart';

class LiveMatchDetails extends Equatable{
  final Time time;
  final Team team;
  final Player player;
  final Assist assist;
  final String type;
  final String detail;

  const LiveMatchDetails({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
  });
  @override
  List<Object?> get props => [time,team,player,assist,type,detail];

}

class Time extends Equatable{
  final int elapsed;
  final int? extra;

  const Time({
    required this.elapsed,
    this.extra,
  });
  @override
  List<Object?> get props => [elapsed,extra];
  factory Time.fromJson(Map<String,dynamic> json){
    return Time(
      elapsed: json['elapsed'] ?? 0,
      extra: json['extra'] ?? 0,
    );
  }

}
class Team extends Equatable{
  final int id;
  final String name;
  final String logo;
  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });
  @override
  List<Object?> get props => [id,name,logo];
  factory Team.fromJson(Map<String,dynamic> json){
    return Team(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'None',
      logo: json['logo'] ?? 'None',
    );
  }
}
class Player extends Equatable{
  final int? id;
  final String? name;

  const Player({
     this.id,
     this.name,

  });
  @override
  List<Object?> get props => [id,name];
  factory Player.fromJson(Map<String,dynamic> json){
    return Player(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'None',
    );
  }
}

class Assist extends Equatable{
  final int? id;
  final String? name;

  const Assist({
     this.id,
     this.name,

  });
  @override
  List<Object?> get props => [id,name];
  factory Assist.fromJson(Map<String,dynamic> json){
    return Assist(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'None',
    );
  }
}
