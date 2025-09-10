import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:football_app/core/error/failure.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../entity/live_match.dart';
import '../repo/base_match_repo.dart';

class GetUpcomingMatchUseCase extends BaseUseCase<List<LiveMatch>, UpcomingMatchParameters> {
  final BaseMatchRepo baseMatchRepo;
  GetUpcomingMatchUseCase(this.baseMatchRepo);
  @override
  Future<Either<Failure, List<LiveMatch>>> call(UpcomingMatchParameters parameters) async{
    return await baseMatchRepo.getUpcomingMatch(parameters);
  }
}

class UpcomingMatchParameters extends Equatable {
  final String date;
  const UpcomingMatchParameters({required this.date});
  @override
  List<Object?> get props => [date];
}