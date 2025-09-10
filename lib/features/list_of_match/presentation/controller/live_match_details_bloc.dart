import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/features/list_of_match/domain/entity/match_statistics.dart';

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
  }

  Future<void> getLiveMatchDetails(
    GetLiveMatchDetailsEvent event,
    Emitter<LiveMatchDetailsState> emit,
  ) async {
    emit(state.copyWith(liveMatchDetailsState: RequestState.loading));
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
      (r) => emit(
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
}
