part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object?> get props =>[];
}

class GetLiveMatchEvent extends MatchEvent{}
class GetUpcomingMatchEvent extends MatchEvent{
  final String date;
  const GetUpcomingMatchEvent({required this.date});
  @override
  List<Object?> get props => [date];
}


class LoadFavoritesEvent extends MatchEvent {}
class ToggleFavoriteEvent extends MatchEvent {
  final LiveMatchModel teamId;
  const ToggleFavoriteEvent(this.teamId);
  @override
  List<Object> get props => [teamId];
}

