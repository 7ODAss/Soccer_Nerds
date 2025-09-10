import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/core/error/failure.dart';
import 'package:football_app/core/usecase/base_usecase.dart';
import 'package:football_app/features/list_of_match/domain/entity/team_form.dart';

import '../repo/base_match_repo.dart';

class GetTeamFormUseCase extends BaseUseCase<List<TeamForm>, TeamFormParameters>{
  final BaseMatchRepo baseMatchRepo;
  GetTeamFormUseCase(this.baseMatchRepo);
  @override
  Future<Either<Failure, List<TeamForm>>> call(TeamFormParameters parameters) async{
    return await baseMatchRepo.getTeamForm(parameters);
  }

}

class TeamFormParameters extends Equatable{
  final int id;

  const TeamFormParameters({required this.id});
  @override
  List<Object?> get props => [id];

}