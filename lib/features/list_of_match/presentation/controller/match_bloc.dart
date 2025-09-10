import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/utils/enums.dart';
import 'package:football_app/features/list_of_match/data/model/live_match_model.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match_details.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_live_match_usecase.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../favorite/services/favorite_service.dart';
import '../../domain/entity/team_form.dart';
import '../../domain/usecase/get_live_match_details_usecase.dart';
import '../../domain/usecase/get_team_form_usecase.dart';
import '../../domain/usecase/get_upcoming_match_usecase.dart';
part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final GetLiveMatchUseCase getLiveMatchUseCase;
  final GetUpcomingMatchUseCase getUpcomingMatchUseCase;
  final FavoriteService favoriteService;


  MatchBloc(
    this.getLiveMatchUseCase,
    this.getUpcomingMatchUseCase,
    this.favoriteService,
  ) : super(MatchState()) {
    on<GetLiveMatchEvent>(getLiveMatch);
    on<GetUpcomingMatchEvent>(getUpcomingMatch);
    on<LoadFavoritesEvent>(loadFavorites);
    on<ToggleFavoriteEvent>(toggleFavorite);

  }

  Future<void> getLiveMatch(
    GetLiveMatchEvent event,
    Emitter<MatchState> emit,
  ) async {
    final result = await getLiveMatchUseCase(NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          liveMatchMessage: l.message,
          liveMatchState: RequestState.error,
        ),
      ),
      (r) => emit(
        state.copyWith(liveMatchState: RequestState.success, liveMatch: r.map((e) => LiveMatchModel.fromDomain(e),).toList()),
      ),
    );
  }

  Future<void> getUpcomingMatch(
    GetUpcomingMatchEvent event,
    Emitter<MatchState> emit,
  ) async {

    final result = await getUpcomingMatchUseCase(
      UpcomingMatchParameters(date: event.date),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          upcomingMatchMessage: l.message,
          upcomingMatchState: RequestState.error,
        ),
      ),
      (r) => emit(
        state.copyWith(upcomingMatchState: RequestState.success, upcomingMatch: r.map((e) => LiveMatchModel.fromDomain(e),).toList()),
      ),
    );
  }


  FutureOr<void> loadFavorites(LoadFavoritesEvent event, Emitter<MatchState> emit) async{
    final List<LiveMatchModel> favoriteIds = await favoriteService.getAll();
    emit(state.copyWith(favoriteTeamIds: favoriteIds));
  }

  FutureOr<void> toggleFavorite(ToggleFavoriteEvent event, Emitter<MatchState> emit) async{
    final LiveMatchModel teamId = event.teamId;
    final bool isFavorite = await favoriteService.isFavorite(teamId.fixture.id);
    if (isFavorite) {
      await favoriteService.removeFavorite(teamId.fixture.id);
    } else {
      await favoriteService.addFavorite(teamId);
    }
    add(LoadFavoritesEvent());
  }
}
