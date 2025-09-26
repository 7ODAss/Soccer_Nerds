import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/features/ai/service/aianalystservice.dart';
import 'package:football_app/features/list_of_match/domain/entity/match_statistics.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entity/live_match_details.dart';
import '../../domain/entity/team_form.dart';
import '../../domain/usecase/get_live_match_details_usecase.dart';
import '../../domain/usecase/get_match_statistics_usecase.dart';
import '../../domain/usecase/get_team_form_usecase.dart';

part 'live_match_details_event.dart';

part 'live_match_details_state.dart';

class LiveMatchDetailsBloc extends Bloc<LiveMatchDetailsEvent, LiveMatchDetailsState> {
  final GetLiveMatchDetailsUseCase getLiveMatchDetailsUseCase;
  final GetTeamFormUseCase getTeamFormUseCase;
  final GetMatchStatisticsUseCase getMatchStatisticsUseCase;

  LiveMatchDetailsBloc(this.getLiveMatchDetailsUseCase, this.getTeamFormUseCase, this.getMatchStatisticsUseCase)
    : super(LiveMatchDetailsState()) {
    on<GetLiveMatchDetailsEvent>(getLiveMatchDetails);
    on<GetTeamFormEvent>(getTeamForm);
    on<GetMatchStatisticsEvent>(getMatchStatistics);
    on<ChangeScreenEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
    on<ChangeTeamEvent>((event, emit) {
      emit(state.copyWith(teamIndex: event.teamIndex));
    });
    on<GetAiMatchPreviewEvent>(getAiMatchPreview);
  }

  Future<void> getLiveMatchDetails(
    GetLiveMatchDetailsEvent event,
    Emitter<LiveMatchDetailsState> emit,
  ) async {
    final result = await getLiveMatchDetailsUseCase(
      LiveMatchDetailsParameters(id: event.id),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          liveMatchDetailsMessage: l.message,
          liveMatchDetailsState: RequestState.error,
        ),
      ),
      (r)  => emit(
        state.copyWith(
          liveMatchDetailsState: RequestState.success,
          liveMatchDetails: r,
        ),
      ),
    );
  }

  Future<void> getTeamForm(
    GetTeamFormEvent event,
    Emitter<LiveMatchDetailsState> emit,
  ) async {
    emit(state.copyWith(teamFormState: RequestState.loading));
    final result = await getTeamFormUseCase(TeamFormParameters(id: event.id));
    result.fold(
      (l) => emit(
        state.copyWith(
          teamFormMessage: l.message,
          teamFormState: RequestState.error,
        ),
      ),
      (r) =>
        emit(state.copyWith(teamFormState: RequestState.success, teamForm: r)),

    );
  }

  Future<void> getMatchStatistics(GetMatchStatisticsEvent event, Emitter<LiveMatchDetailsState> emit) async{
    final result = await getMatchStatisticsUseCase(MatchStatisticsParameters(id: event.id));
    result.fold(
          (l) => emit(
        state.copyWith(
          statisticsMessage: l.message,
          statisticsState: RequestState.error,
        ),
      ),
          (r) =>
          emit(state.copyWith(statisticsState: RequestState.success, statistics: r)),

    );
  }

  FutureOr<void> getAiMatchPreview(GetAiMatchPreviewEvent event, Emitter<LiveMatchDetailsState> emit) async{
    if (state.liveMatchDetails == null || state.liveMatchDetails!.isEmpty) {
      emit(state.copyWith(aiMatchPreview: "Match details not loaded. Cannot generate preview."));
      return;
    }

    // You might want to indicate that AI analysis is in progress
    // This could be a specific field in the state e.g., aiPreviewStatus
    // For simplicity here, we'll just update aiMatchPreview when done.
    // emit(state.copyWith(aiMatchPreview: "Generating AI insight...")); // Temporary message


    final String aiPreviewText = await getIt<AiAnalystService>().analyzeMatch(
      state.liveMatchDetails, // This is a single LiveMatchDetails object
      state.statistics,   // This is List<MatchStatistics>
    );

    emit(state.copyWith(aiMatchPreview: aiPreviewText));
  }
}
