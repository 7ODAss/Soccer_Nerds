import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/player_profile.dart';
import '../usecase/get_standing_usecase.dart';

abstract class BaseStandingLeagueRepo {
  Future<Either<Failure, List<League>>> getLeague();
  Future<Either<Failure, List<Standing>>> getStanding(StandingParameters parameters);
}