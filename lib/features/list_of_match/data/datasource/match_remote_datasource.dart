import 'package:dio/dio.dart';
import 'package:football_app/core/network/error_message_model.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_upcoming_match_usecase.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/api_constant.dart';
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
    final response = await Dio().get(
      ApiConstant.fixtureLive,
      options: Options(headers: ApiConstant.headers),
    );
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
  Future<List<LiveMatchModel>> getUpcomingMatch(
    UpcomingMatchParameters parameters,
  ) async {
    final response = await Dio().get(
      ApiConstant.upcomingMatch(parameters.date),
      options: Options(headers: ApiConstant.headers),
    );
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
    final response = await Dio().get(
      ApiConstant.liveMatchDetails(parameters.id),
      options: Options(headers: ApiConstant.headers),
    );
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
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
    final response = await Dio().get(
      ApiConstant.liveMatchLineUp(parameters.id),
      options: Options(headers: ApiConstant.headers),
    );
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      print('TeamForm datasource data');
      print(response.data);
      if (response.data['response'].isEmpty) {
        print("API returned an empty list for lineups for fixture ID: ${parameters.id}");
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
    final response = await Dio().get(
      ApiConstant.liveMatchStatistics(parameters.id),
      options: Options(headers: ApiConstant.headers),
    );
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      print('statistics datasource data');
      print(response.data);
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
