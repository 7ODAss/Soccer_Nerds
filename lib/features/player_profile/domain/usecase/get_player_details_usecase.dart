import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/core/usecase/base_usecase.dart';
import '../entity/player_details.dart';
import '../repo/base_player_profile_repo.dart';

class GetPlayerDetailsUseCase extends BaseUseCase<List<PlayerDetails>,PlayerDetailsParameters>{
  final BasePlayerProfileRepo basePlayerProfileRepo;
  GetPlayerDetailsUseCase(this.basePlayerProfileRepo);
  @override
  Future<Either<Failure, List<PlayerDetails>>> call(PlayerDetailsParameters parameters) async{
   return await basePlayerProfileRepo.getPlayerProfileDetails(parameters);
  }

}

class PlayerDetailsParameters extends Equatable{
  final int id;
  const PlayerDetailsParameters({
    required this.id,
  });
  @override
  List<Object?> get props => [id];

}