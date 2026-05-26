import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/player_details.dart';
import '../entity/player_profile.dart';
import '../usecase/get_player_details_usecase.dart';
import '../usecase/get_player_profile_search_usecase.dart';
import '../usecase/get_player_profile_usecase.dart';

abstract class BasePlayerProfileRepo {
  Future<Either<Failure, List<PlayerProfile>>> getPlayerProfile(PlayerProfileParameters parameters);
  Future<Either<Failure, List<PlayerDetails>>> getPlayerProfileDetails(PlayerDetailsParameters parameters);
  Future<Either<Failure, List<PlayerProfile>>> getPlayerProfileSearch(PlayerProfileSearchParameters parameters);
}