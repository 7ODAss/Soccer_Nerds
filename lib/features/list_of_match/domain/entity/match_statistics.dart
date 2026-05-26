import 'package:equatable/equatable.dart';

import 'live_match_details.dart';

class MatchStatistics extends Equatable{
  final Team team;
  final List<Statistics>statistics;
  const MatchStatistics({
    required this.team,
    required this.statistics,
  });
  @override
  List<Object?> get props => [team,statistics];

}

class Statistics extends Equatable {
  final String type;
  final dynamic value;

  const Statistics({
    required this.type,
    required this.value,
  });
  @override
  List<Object?> get props => [type,value];

}