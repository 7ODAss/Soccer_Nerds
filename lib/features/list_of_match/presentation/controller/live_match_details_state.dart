part of 'live_match_details_bloc.dart';

 class LiveMatchDetailsState extends Equatable {
   final List<LiveMatchDetails> liveMatchDetails;
   final RequestState liveMatchDetailsState;
   final String liveMatchDetailsMessage;

   final List<TeamForm> teamForm;
   final RequestState teamFormState;
   final String teamFormMessage;

   final List<MatchStatistics>statistics;
   final RequestState statisticsState;
   final String statisticsMessage;

   final int index;
   final int teamIndex;

   final String? aiMatchPreview;

   const LiveMatchDetailsState({
     this.liveMatchDetails = const [],
     this.liveMatchDetailsState = RequestState.loading,
     this.liveMatchDetailsMessage = '',
     this.teamForm = const [],
     this.teamFormState = RequestState.loading,
     this.teamFormMessage = '',
     this.statistics = const [],
     this.statisticsState = RequestState.loading,
     this.statisticsMessage = '',
     this.index = 0,
     this.teamIndex = 0,
     this.aiMatchPreview,
   });

   LiveMatchDetailsState copyWith({
     List<LiveMatchDetails>? liveMatchDetails,
     RequestState? liveMatchDetailsState,
     String? liveMatchDetailsMessage,
     List<TeamForm>? teamForm,
     RequestState? teamFormState,
     String? teamFormMessage,
     List<MatchStatistics>?statistics,
     RequestState?statisticsState,
     String?statisticsMessage,
     int?index,
     int?teamIndex,
     String? aiMatchPreview,
   }) {
     return LiveMatchDetailsState(
       liveMatchDetails: liveMatchDetails ?? this.liveMatchDetails,
       liveMatchDetailsState: liveMatchDetailsState ?? this.liveMatchDetailsState,
       liveMatchDetailsMessage: liveMatchDetailsMessage ?? this.liveMatchDetailsMessage,

       teamForm: teamForm ?? this.teamForm,
       teamFormState: teamFormState ?? this.teamFormState,
       teamFormMessage: teamFormMessage ?? this.teamFormMessage,

       statistics: statistics ?? this.statistics,
       statisticsState: statisticsState ?? this.statisticsState,
       statisticsMessage: statisticsMessage ?? this.statisticsMessage,

       index: index ?? this.index,
       teamIndex: teamIndex ?? this.teamIndex,
       aiMatchPreview: aiMatchPreview ?? this.aiMatchPreview,
     );
   }

   @override
   List<Object?> get props => [
     liveMatchDetails,
     liveMatchDetailsState,
     liveMatchDetailsMessage,

     teamForm,
     teamFormState,
     teamFormMessage,

     statistics,
     statisticsState,
     statisticsMessage,

     index,
     teamIndex,
     aiMatchPreview,
   ];
}
