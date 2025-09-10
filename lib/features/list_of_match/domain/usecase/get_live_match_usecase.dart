import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entity/live_match.dart';
import '../repo/base_match_repo.dart';

class GetLiveMatchUseCase extends BaseUseCase<List<LiveMatch>, NoParameters>{
  final BaseMatchRepo baseMatchRepo;
  GetLiveMatchUseCase(this.baseMatchRepo);

  @override
  Future<Either<Failure, List<LiveMatch>>> call(NoParameters parameters) async{
    return await baseMatchRepo.getLiveMatch();
  }

}
