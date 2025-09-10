import 'package:dartz/dartz.dart';
import 'package:football_app/core/error/exception.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match_details.dart';
import 'package:football_app/features/list_of_match/domain/entity/match_statistics.dart';
import 'package:football_app/features/list_of_match/domain/entity/team_form.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_live_match_details_usecase.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_match_statistics_usecase.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_team_form_usecase.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repo/base_match_repo.dart';
import '../../domain/usecase/get_upcoming_match_usecase.dart';
import '../datasource/match_remote_datasource.dart';

class MatchRepo extends BaseMatchRepo {
  final BaseMatchRemoteDataSource baseMatchRemoteDataSource;
   MatchRepo(
    this.baseMatchRemoteDataSource,
  );
  @override
  Future<Either<Failure, List<LiveMatch>>> getLiveMatch() async{

   try{
     final result = await baseMatchRemoteDataSource.getLiveMatch();
     return Right(result);
   }on ServerException catch(e){
     return Left(ServerFailure(e.serverMessage.message));
   }
  }

  @override
  Future<Either<Failure, List<LiveMatch>>> getUpcomingMatch(UpcomingMatchParameters parameters) async{

    try{
      final result = await baseMatchRemoteDataSource.getUpcomingMatch(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<LiveMatchDetails>>> getLiveMatchDetails(LiveMatchDetailsParameters parameters) async {

    try{
      final result = await baseMatchRemoteDataSource.getLiveMatchDetails(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<TeamForm>>> getTeamForm(TeamFormParameters parameters) async{
    try{
      final result = await baseMatchRemoteDataSource.getTeamForm(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<MatchStatistics>>> getMatchStatistics(MatchStatisticsParameters parameters) async{
    try{
      final result = await baseMatchRemoteDataSource.getMatchStatistics(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }
}