import 'package:flutter/cupertino.dart';
import 'package:football_app/core/network/error_message_model.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_upcoming_match_usecase.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/api_constant.dart';
import '../../../../core/utils/dio_config.dart';
import '../../domain/usecase/get_live_match_details_usecase.dart';
import '../../domain/usecase/get_match_statistics_usecase.dart';
import '../../domain/usecase/get_team_form_usecase.dart';
import '../model/live_match_details_model.dart';
import '../model/live_match_model.dart';
import '../model/match_statistics_model.dart';
import '../model/team_form_model.dart';

abstract class BaseMatchRemoteDataSource {
  Future<List<LiveMatchModel>> getLiveMatch();

  Future<List<LiveMatchModel>> getUpcomingMatch(
    UpcomingMatchParameters parameters,
  );

  Future<List<LiveMatchDetailsModel>> getLiveMatchDetails(
    LiveMatchDetailsParameters parameters,
  );

  Future<List<TeamFormModel>> getTeamForm(TeamFormParameters parameters);

  Future<List<MatchStatisticsModel>> getMatchStatistics(MatchStatisticsParameters parameters);
}

class MatchRemoteDataSource extends BaseMatchRemoteDataSource {
  @override
  Future<List<LiveMatchModel>> getLiveMatch() async {
    final response = await DioConfig.getData(path: ApiConstant.fixtureLive);
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
     return List<LiveMatchModel>.from((response.data['response'] as List).map((e) => LiveMatchModel.fromJson(e),),).toList();
    } else {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<LiveMatchModel>> getUpcomingMatch(
    UpcomingMatchParameters parameters,
  ) async {
    final response = await DioConfig.getData(path:  ApiConstant.upcomingMatch(parameters.date));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      return List<LiveMatchModel>.from(
        (response.data['response'] as List).map(
          (e) => LiveMatchModel.fromJson(e),
        ),
      ).toList();
    } else {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<LiveMatchDetailsModel>> getLiveMatchDetails(
    LiveMatchDetailsParameters parameters,
  ) async {
    final response = await DioConfig.getData(path:  ApiConstant.liveMatchDetails(parameters.id));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      if (response.data['response'].isEmpty) {
        debugPrint("API returned an empty list for lineups for fixture ID: ${parameters.id}");
        return [];
      }
      return List<LiveMatchDetailsModel>.from(
        (response.data['response'] as List).map(
          (e) => LiveMatchDetailsModel.fromJson(e),
        ),
      ).toList();
    } else {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TeamFormModel>> getTeamForm(TeamFormParameters parameters) async {
    final response = await DioConfig.getData(path: ApiConstant.liveMatchLineUp(parameters.id));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      debugPrint('TeamForm datasource data');
      if (response.data['response'].isEmpty) {
        debugPrint("API returned an empty list for lineups for fixture ID: ${parameters.id}");
        return [];
      }
      return List<TeamFormModel>.from(
        (response.data['response'] as List).map(
              (e) => TeamFormModel.fromJson(e),
        ),
      ).toList();
    } else {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MatchStatisticsModel>> getMatchStatistics(MatchStatisticsParameters parameters) async{
    final response = await DioConfig.getData(path: ApiConstant.liveMatchStatistics(parameters.id));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      debugPrint('statistics datasource data');
      return List<MatchStatisticsModel>.from(
        (response.data['response'] as List).map(
              (e) => MatchStatisticsModel.fromJson(e),
        ),
      ).toList();
    } else {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
