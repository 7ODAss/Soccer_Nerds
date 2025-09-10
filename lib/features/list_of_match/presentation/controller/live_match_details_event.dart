part of 'live_match_details_bloc.dart';

abstract class LiveMatchDetailsEvent extends Equatable {
  const LiveMatchDetailsEvent();

  @override
  List<Object> get props =>[];
}

class GetLiveMatchDetailsEvent extends LiveMatchDetailsEvent{
  final int id;
  const GetLiveMatchDetailsEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class GetTeamFormEvent extends LiveMatchDetailsEvent {
  final int id;
  const GetTeamFormEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class GetMatchStatisticsEvent extends LiveMatchDetailsEvent {
  final int id;
  const GetMatchStatisticsEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class ChangeScreenEvent extends LiveMatchDetailsEvent {
  final int index;
  const ChangeScreenEvent(this.index);
  @override
  List<Object> get props => [index];
}
class ChangeTeamEvent extends LiveMatchDetailsEvent {
  final int teamIndex;
  const ChangeTeamEvent(this.teamIndex);
  @override
  List<Object> get props => [teamIndex];
}
