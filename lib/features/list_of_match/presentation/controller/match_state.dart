part of 'match_bloc.dart';

class MatchState extends Equatable {
  final List<LiveMatchModel> liveMatch;
  final RequestState liveMatchState;
  final String liveMatchMessage;
  final List<LiveMatchModel> upcomingMatch;
  final RequestState upcomingMatchState;
  final String upcomingMatchMessage;

  final List<LiveMatchModel> favoriteTeamIds;

  const MatchState({
    this.liveMatch = const [],
    this.liveMatchState = RequestState.loading,
    this.liveMatchMessage = '',
    this.upcomingMatch = const [],
    this.upcomingMatchState = RequestState.loading,
    this.upcomingMatchMessage = '',

    this.favoriteTeamIds = const [],

  });

  MatchState copyWith({
    List<LiveMatchModel>? liveMatch,
    RequestState? liveMatchState,
    String? liveMatchMessage,
    List<LiveMatchModel>? upcomingMatch,
    RequestState? upcomingMatchState,
    String? upcomingMatchMessage,

    List<LiveMatchModel>? favoriteTeamIds,

    List<TeamForm>? teamForm,
    RequestState? teamFormState,
    String? teamFormMessage,

  }) {
    return MatchState(
      liveMatch: liveMatch ?? this.liveMatch,
      liveMatchState: liveMatchState ?? this.liveMatchState,
      liveMatchMessage: liveMatchMessage ?? this.liveMatchMessage,
      upcomingMatch: upcomingMatch ?? this.upcomingMatch,
      upcomingMatchState: upcomingMatchState ?? this.upcomingMatchState,
      upcomingMatchMessage: upcomingMatchMessage ?? this.upcomingMatchMessage,

      favoriteTeamIds: favoriteTeamIds ?? this.favoriteTeamIds,

    );
  }

  @override
  List<Object?> get props => [
    liveMatch,
    liveMatchState,
    liveMatchMessage,
    upcomingMatch,
    upcomingMatchState,
    upcomingMatchMessage,

    favoriteTeamIds,
  ];
}
