import 'package:equatable/equatable.dart';
import 'package:football_app/features/leagues/domain/entity/player_profile.dart';

abstract class StandingEvent extends Equatable {
  const StandingEvent();
  @override
  List<Object?> get props =>[];
}

class GetLeagueEvent extends StandingEvent {}
class LeagueSelectedEvent extends StandingEvent{
  final League league;
  const LeagueSelectedEvent(this.league);
  @override
  List<Object?> get props => [league];
}

