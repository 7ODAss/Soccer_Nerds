import 'package:dartz/dartz.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match_details.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_live_match_details_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/live_match.dart';
import '../entity/match_statistics.dart';
import '../entity/team_form.dart';
import '../usecase/get_match_statistics_usecase.dart';
import '../usecase/get_team_form_usecase.dart';
import '../usecase/get_upcoming_match_usecase.dart';

abstract class BaseMatchRepo {
  Future<Either<Failure, List<LiveMatch>>> getLiveMatch();
  Future<Either<Failure, List<LiveMatch>>> getUpcomingMatch(UpcomingMatchParameters parameters);
  Future<Either<Failure, List<LiveMatchDetails>>> getLiveMatchDetails(LiveMatchDetailsParameters parameters);
  Future<Either<Failure, List<TeamForm>>> getTeamForm(TeamFormParameters parameters);
  Future<Either<Failure, List<MatchStatistics>>> getMatchStatistics(MatchStatisticsParameters parameters);
}