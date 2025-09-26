import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/core/usecase/base_usecase.dart';
import 'package:football_app/features/player_profile/domain/entity/player_profile.dart';
import '../repo/base_player_profile_repo.dart';

class GetPlayerProfileSearchUseCase extends BaseUseCase<List<PlayerProfile>,PlayerProfileSearchParameters>{
  final BasePlayerProfileRepo basePlayerProfileRepo;
  GetPlayerProfileSearchUseCase(this.basePlayerProfileRepo);
  @override
  Future<Either<Failure, List<PlayerProfile>>> call(PlayerProfileSearchParameters parameters) async{
    return await basePlayerProfileRepo.getPlayerProfileSearch(parameters);
  }

}

class PlayerProfileSearchParameters extends Equatable{
  final String name;
  const PlayerProfileSearchParameters(this.name);
  @override
  List<Object?>get props=>[name];

}