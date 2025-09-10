import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/utils/api_constant.dart';
import '../../domain/usecase/get_standing_usecase.dart';
import '../model/league_model.dart';
import '../model/standing_model.dart';

abstract class BaseStandingLeagueRemoteDataSource {
  Future<List<LeagueModel>> getLeague();
  Future<List<StandingModel>> getStanding(StandingParameters parameters);
}

class StandingLeagueRemoteDataSource extends BaseStandingLeagueRemoteDataSource {
  @override
  Future<List<LeagueModel>> getLeague() async {
    final response = await Dio().get(
      ApiConstant.allLeague, // Corrected constant name
      options: Options(
        headers: ApiConstant.headers,
      ),
    );
    if (response.data['errors'] != null &&
        response.data['errors'].isNotEmpty) {
      throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data));
    } else if (response.statusCode == 200) {
      final List<dynamic> leagueData = response.data['response'];
      // Filter the leagues that have standings coverage
      return leagueData
          .where((leagueJson) =>
      leagueJson['seasons'][0]['coverage']['standings'] == true)
          .map((leagueJson) => LeagueModel.fromJson(leagueJson))
          .toList();
    } else {
      throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<StandingModel>> getStanding(StandingParameters parameters) async {
    final response = await Dio().get(
      ApiConstant.standingsByLeague(parameters.leagueId, parameters.season),
      options: Options(
        headers: ApiConstant.headers,
      ),
    );
    if (response.data['errors'] != null &&
        response.data['errors'].isNotEmpty) {
      throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data));
    } else if (response.statusCode == 200) {
      // --- THIS IS THE FIX ---

      // 1. Safety Check: If the 'response' list is empty, return an empty list.
      if (response.data['response'].isEmpty) {
        return [];
      }

      // 2. Correctly navigate to the deeply nested list of standings.
      final List<dynamic> standingsData =
      response.data['response'][0]['league']['standings'][0];

      // 3. Map over the correct list.
      return standingsData
          .map((e) => StandingModel.fromJson(e))
          .toList();
    } else {
      throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data));
    }
  }
}
