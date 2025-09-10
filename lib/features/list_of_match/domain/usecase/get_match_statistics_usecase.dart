import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entity/match_statistics.dart';
import '../repo/base_match_repo.dart';

class GetMatchStatisticsUseCase extends BaseUseCase<List<MatchStatistics>, MatchStatisticsParameters>{
  final BaseMatchRepo baseMatchRepo;
  GetMatchStatisticsUseCase(this.baseMatchRepo);
  @override
  Future<Either<Failure, List<MatchStatistics>>> call(MatchStatisticsParameters parameters) async{
    return await baseMatchRepo.getMatchStatistics(parameters);
  }
}

class MatchStatisticsParameters extends Equatable{
  final int id;
  const MatchStatisticsParameters({required this.id});

  @override
  List<Object?> get props => [id];
}