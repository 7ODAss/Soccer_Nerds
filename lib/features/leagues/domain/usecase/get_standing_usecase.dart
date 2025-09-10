import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/features/leagues/domain/repo/base_standing_league_repo.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../list_of_match/domain/repo/base_match_repo.dart';
import '../entity/standing_league.dart';

class GetStandingUseCase extends BaseUseCase<List<Standing>, StandingParameters> {
  final BaseStandingLeagueRepo baseStandingLeagueRepo;
  GetStandingUseCase(this.baseStandingLeagueRepo);
  @override
  Future<Either<Failure, List<Standing>>> call(StandingParameters parameters) async{
    return await baseStandingLeagueRepo.getStanding(parameters);
  }

}

class StandingParameters extends Equatable{
  final int leagueId;
  final int season;
  const StandingParameters({required this.leagueId, required this.season});

  @override
  List<Object?> get props => [leagueId, season];
}