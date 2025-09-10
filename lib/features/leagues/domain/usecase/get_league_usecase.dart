import 'package:dartz/dartz.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/features/leagues/domain/repo/base_standing_league_repo.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../list_of_match/domain/repo/base_match_repo.dart';
import '../entity/standing_league.dart';

class GetLeagueUseCase extends BaseUseCase<List<League>, NoParameters> {
  final BaseStandingLeagueRepo baseStandingLeagueRepo;
  GetLeagueUseCase(this.baseStandingLeagueRepo);
  @override
  Future<Either<Failure, List<League>>> call(NoParameters parameters) async{
    return await baseStandingLeagueRepo.getLeague();
  }

}