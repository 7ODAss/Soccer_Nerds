import 'package:dartz/dartz.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/features/leagues/domain/entity/player_profile.dart';
import 'package:football_app/features/leagues/domain/repo/base_player_profile_repo.dart';
import 'package:football_app/features/leagues/domain/usecase/get_standing_usecase.dart';
import '../../../../core/error/exception.dart';
import '../datasource/player_profile_remote_datasource.dart';

class StandingLeagueRepo extends BaseStandingLeagueRepo{
  final BasePlayerProfileRemoteDataSource baseStandingLeagueRemoteDataSource;
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