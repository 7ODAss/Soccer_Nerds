import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/core/usecase/base_usecase.dart';
import 'package:football_app/features/player_profile/domain/entity/player_profile.dart';
import 'package:football_app/features/player_profile/domain/repo/base_player_profile_repo.dart';

class GetPlayerProfileUseCase extends BaseUseCase<List<PlayerProfile>, PlayerProfileParameters> {
  final BasePlayerProfileRepo basePlayerProfileRepo;
  GetPlayerProfileUseCase(this.basePlayerProfileRepo);

  @override
  Future<Either<Failure, List<PlayerProfile>>> call(PlayerProfileParameters parameters) async{
   return await basePlayerProfileRepo.getPlayerProfile(parameters);
  }

}

class PlayerProfileParameters extends Equatable{
  final int page;
  const PlayerProfileParameters({
    required this.page,
  });
  @override
  List<Object?> get props => [page];
}