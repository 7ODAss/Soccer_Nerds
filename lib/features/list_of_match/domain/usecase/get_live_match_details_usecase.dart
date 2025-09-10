import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/core/usecase/base_usecase.dart';

import '../entity/live_match_details.dart';
import '../repo/base_match_repo.dart';

class GetLiveMatchDetailsUseCase extends BaseUseCase<List<LiveMatchDetails>,LiveMatchDetailsParameters>{
  final BaseMatchRepo baseMatchRepo;

  GetLiveMatchDetailsUseCase(this.baseMatchRepo);
  @override
  Future<Either<Failure, List<LiveMatchDetails>>> call(LiveMatchDetailsParameters parameters) async{
   return await baseMatchRepo.getLiveMatchDetails(parameters);
  }

}

class LiveMatchDetailsParameters extends Equatable{
  final int id;

  const LiveMatchDetailsParameters({required this.id});

  @override
  List<Object?> get props => [id];
}

