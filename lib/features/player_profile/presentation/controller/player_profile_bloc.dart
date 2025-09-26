import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:football_app/features/player_profile/data/model/player_profile_model.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_event.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_state.dart';
import '../../../../core/utils/enums.dart';
import '../../data/model/player_details_model.dart';
import '../../domain/usecase/get_player_details_usecase.dart';
import '../../domain/usecase/get_player_profile_search_usecase.dart';
import '../../domain/usecase/get_player_profile_usecase.dart';

class PlayerProfileBloc extends Bloc<PlayerProfileEvent, PlayerProfileState> {
  final GetPlayerProfileUseCase getPlayerProfileUseCase;
  final GetPlayerDetailsUseCase getPlayerDetailsUseCase;
  final GetPlayerProfileSearchUseCase getPlayerProfileSearchUseCase;

  PlayerProfileBloc(this.getPlayerProfileUseCase, this.getPlayerDetailsUseCase,this.getPlayerProfileSearchUseCase)
    : super(PlayerProfileState()) {
    on<GetPlayerProfileEvent>(getPlayerProfile);
    on<GetPlayerDetailsEvent>(getPlayerDetails);
    on<ChangeScreenEvent>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });
    on<GetPlayerProfileSearchEvent>(getPlayerProfileSearch);
  }

  FutureOr<void> getPlayerProfile(
    GetPlayerProfileEvent event,
    Emitter<PlayerProfileState> emit,
  ) async {
    final result = await getPlayerProfileUseCase(
      PlayerProfileParameters(page: event.page),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          playerProfileMessage: l.message,
          playerProfileState: RequestState.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          playerProfileState: RequestState.success,
          playerProfile:
              r.map((e) => PlayerProfileModel.fromDomain(e)).toList(),
        ),
      ),
    );
  }

  FutureOr<void> getPlayerDetails(
    GetPlayerDetailsEvent event,
    Emitter<PlayerProfileState> emit,
  ) async {
    final result = await getPlayerDetailsUseCase(
      PlayerDetailsParameters(id: event.id),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          playerDetailsMessage: l.message,
          playerDetailsState: RequestState.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          playerDetailsState: RequestState.success,
          playerDetails:
              r.map((e) => PlayerDetailsModel.fromDomain(e)).toList(),
        ),
      ),
    );
  }

  FutureOr<void> getPlayerProfileSearch(GetPlayerProfileSearchEvent event, Emitter<PlayerProfileState> emit) async{
    final result = await getPlayerProfileSearchUseCase(PlayerProfileSearchParameters(event.name));
    result.fold(
          (l) => emit(
        state.copyWith(
          playerProfileSearchMessage: l.message,
          playerProfileSearchState: RequestState.error,
        ),
      ),
          (r) => emit(
        state.copyWith(
          playerProfileSearchState: RequestState.success,
          playerProfileSearch:
          r.map((e) => PlayerProfileModel.fromDomain(e)).toList(),
        ),
      ),
    );
  }
}
