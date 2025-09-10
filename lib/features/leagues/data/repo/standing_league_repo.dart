import 'package:dartz/dartz.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/features/leagues/domain/entity/standing_league.dart';
import 'package:football_app/features/leagues/domain/repo/base_standing_league_repo.dart';
import 'package:football_app/features/leagues/domain/usecase/get_standing_usecase.dart';
import '../../../../core/error/exception.dart';
import '../datasource/standing_league_remote_datasource.dart';

class StandingLeagueRepo extends BaseStandingLeagueRepo{
  final BaseStandingLeagueRemoteDataSource baseStandingLeagueRemoteDataSource;
  StandingLeagueRepo(this.baseStandingLeagueRemoteDataSource);

  @override
  Future<Either<Failure, List<League>>> getLeague() async{
    try{
      final result = await baseStandingLeagueRemoteDataSource.getLeague();
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<Standing>>> getStanding(StandingParameters parameters)async {
    try{
      final result = await baseStandingLeagueRemoteDataSource.getStanding(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }


}