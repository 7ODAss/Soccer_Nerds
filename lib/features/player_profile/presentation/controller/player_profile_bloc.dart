

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_app/features/leagues/presentation/controller/standing_event.dart';
import 'package:football_app/features/leagues/presentation/controller/standing_state.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/usecase/get_player_profile_usecase.dart';
import '../../domain/usecase/get_standing_usecase.dart';

class StandingBloc extends Bloc<StandingEvent, StandingState> {
  final GetLeagueUseCase getLeaguesUseCase;
  final GetStandingUseCase getStandingsUseCase;

  StandingBloc(this.getLeaguesUseCase, this.getStandingsUseCase)
    : super(StandingState()) {
    on<GetLeagueEvent>(getLeague);
    on<LeagueSelectedEvent>(getLeagueSelected);
  }

  FutureOr<void> getLeague(
    GetLeagueEvent event,
    Emitter<StandingState> emit,
  ) async {
    final result = await getLeaguesUseCase(NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          leaguesMessage: l.message,
          leaguesState: RequestState.error,
        ),
      ),
      (r) =>
          emit(state.copyWith(leaguesState: RequestState.success, leagues: r)),
    );
  }

  FutureOr<void> getLeagueSelected(
    LeagueSelectedEvent event,
    Emitter<StandingState> emit,
  ) async {
    final result = await getStandingsUseCase(
      StandingParameters(
        leagueId: event.league.id,
        season: 2023,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          standingsMessage: l.message,
          standingsState: RequestState.error,
        ),
      ),
      (r) =>
          emit(state.copyWith(standingsState: RequestState.success, standings: r)),
    );
  }
}
