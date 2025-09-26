import 'package:equatable/equatable.dart';
import 'package:football_app/features/player_profile/data/model/player_profile_model.dart';
import '../../../../core/utils/enums.dart';
import '../../data/model/player_details_model.dart';

class PlayerProfileState extends Equatable {
  final List<PlayerProfileModel> playerProfile;
  final RequestState playerProfileState;
  final String playerProfileMessage;
  final List<PlayerDetailsModel> playerDetails;
  final RequestState playerDetailsState;
  final String playerDetailsMessage;
  final List<PlayerProfileModel> playerProfileSearch;
  final RequestState playerProfileSearchState;
  final String playerProfileSearchMessage;

  final int pageIndex;

  const PlayerProfileState({
    this.playerProfile = const [],
    this.playerProfileState = RequestState.loading,
    this.playerProfileMessage = '',
    this.playerDetails = const [],
    this.playerDetailsState = RequestState.loading,
    this.playerDetailsMessage = '',
    this.playerProfileSearch = const [],
    this.playerProfileSearchState = RequestState.loading,
    this.playerProfileSearchMessage = '',

    this.pageIndex = 1,
  });


  PlayerProfileState copyWith({
    List<PlayerProfileModel>? playerProfile,
    RequestState? playerProfileState,
    String? playerProfileMessage,
    List<PlayerDetailsModel>? playerDetails,
    RequestState? playerDetailsState,
    String? playerDetailsMessage,
    List<PlayerProfileModel>? playerProfileSearch,
    RequestState? playerProfileSearchState,
    String? playerProfileSearchMessage,

    int? pageIndex,
  }) {
    return PlayerProfileState(
      playerProfile: playerProfile ?? this.playerProfile,
      playerProfileState: playerProfileState ?? this.playerProfileState,
      playerProfileMessage: playerProfileMessage ?? this.playerProfileMessage,
      playerDetails: playerDetails ?? this.playerDetails,
      playerDetailsState: playerDetailsState ?? this.playerDetailsState,
      playerDetailsMessage: playerDetailsMessage ?? this.playerDetailsMessage,
      playerProfileSearch: playerProfileSearch ?? this.playerProfileSearch,
      playerProfileSearchState: playerProfileSearchState ?? this.playerProfileSearchState,
      playerProfileSearchMessage: playerProfileSearchMessage ?? this.playerProfileSearchMessage,

      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [
    playerProfile,
    playerProfileState,
    playerProfileMessage,
    playerDetails,
    playerDetailsState,
    playerDetailsMessage,
    playerProfileSearch,
    playerProfileSearchState,
    playerProfileSearchMessage,

    pageIndex,
  ];
}