import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entity/standing_league.dart';

class StandingState extends Equatable {
  final List<League> leagues;
  final RequestState leaguesState;
  final String leaguesMessage;
  final League? selectedLeague;

  final List<Standing> standings;
  final RequestState standingsState;
  final String standingsMessage;

  const StandingState({
    this.leagues = const [],
    this.leaguesState = RequestState.loading,
    this.leaguesMessage = '',
    this.selectedLeague,

    this.standings = const [],
    this.standingsState = RequestState.loading,
    this.standingsMessage = '',
  });


  StandingState copyWith({
    List<League>? leagues,
    RequestState? leaguesState,
    String? leaguesMessage,
    League? selectedLeague,
    List<Standing>? standings,
    RequestState? standingsState,
    String? standingsMessage,
  }) {
    return StandingState(
      leagues: leagues ?? this.leagues,
      leaguesState: leaguesState ?? this.leaguesState,
      leaguesMessage: leaguesMessage ?? this.leaguesMessage,
      selectedLeague: selectedLeague ?? this.selectedLeague,
      standings: standings ?? this.standings,
      standingsState: standingsState ?? this.standingsState,
      standingsMessage: standingsMessage ?? this.standingsMessage,
    );
  }

  @override
  List<Object?> get props => [
    leagues,
    leaguesState,
    leaguesMessage,
    selectedLeague,
    standings,
    standingsState,
    standingsMessage,
  ];
}