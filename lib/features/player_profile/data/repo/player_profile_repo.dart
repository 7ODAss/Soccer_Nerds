import 'package:dartz/dartz.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/features/player_profile/domain/entity/player_profile.dart';
import 'package:football_app/features/player_profile/domain/usecase/get_player_details_usecase.dart';
import 'package:football_app/features/player_profile/domain/usecase/get_player_profile_search_usecase.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entity/player_details.dart';
import '../../domain/repo/base_player_profile_repo.dart';
import '../../domain/usecase/get_player_profile_usecase.dart';
import '../datasource/player_profile_remote_datasource.dart';

class PlayerProfileRepo extends BasePlayerProfileRepo{
  final BasePlayerProfileRemoteDataSource basePlayerProfileRemoteDataSource;
  PlayerProfileRepo(this.basePlayerProfileRemoteDataSource);

  @override
  Future<Either<Failure, List<PlayerProfile>>> getPlayerProfile(PlayerProfileParameters parameters) async{
    try{
      final result = await basePlayerProfileRemoteDataSource.getPlayerProfile(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<PlayerDetails>>> getPlayerProfileDetails(PlayerDetailsParameters parameters) async{
    try{
      final result = await basePlayerProfileRemoteDataSource.getPlayerDetails(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }

  @override
  Future<Either<Failure, List<PlayerProfile>>> getPlayerProfileSearch(PlayerProfileSearchParameters parameters) async{
    try{
      final result = await basePlayerProfileRemoteDataSource.getPlayerProfileSearch(parameters);
      return Right(result);
    }on ServerException catch(e){
      return Left(ServerFailure(e.serverMessage.message));
    }
  }


}