import 'package:flutter/cupertino.dart';
import 'package:football_app/core/utils/dio_config.dart';
import 'package:football_app/features/player_profile/data/model/player_profile_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/utils/api_constant.dart';
import '../../domain/usecase/get_player_details_usecase.dart';
import '../../domain/usecase/get_player_profile_search_usecase.dart';
import '../../domain/usecase/get_player_profile_usecase.dart';
import '../model/player_details_model.dart';

abstract class BasePlayerProfileRemoteDataSource {
  Future<List<PlayerProfileModel>> getPlayerProfile(PlayerProfileParameters parameter);
  Future<List<PlayerDetailsModel>> getPlayerDetails(PlayerDetailsParameters parameter);
  Future<List<PlayerProfileModel>> getPlayerProfileSearch(PlayerProfileSearchParameters parameter);
}

class PlayerProfileRemoteDataSource extends BasePlayerProfileRemoteDataSource {
  @override
    Future<List<PlayerProfileModel>> getPlayerProfile(PlayerProfileParameters parameter) async {
      final response = await DioConfig.getData(path: ApiConstant.allPlayersProfile(parameter.page));
      if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
        throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data),
        );
      } else if (response.statusCode == 200) {
        return List<PlayerProfileModel>.from((response.data['response'] as List).map((e) => PlayerProfileModel.fromJson(e))).toList();
      }
      else{
        throw ServerException(
          serverMessage: ErrorMessageModel.fromJson(response.data),
        );
      }
  }

  @override
  Future<List<PlayerDetailsModel>> getPlayerDetails(PlayerDetailsParameters parameter) async{
    final response = await DioConfig.getData(path: ApiConstant.playerDetails(parameter.id));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      debugPrint('playerDetails');
      return List<PlayerDetailsModel>.from((response.data['response'] as List).map((e) => PlayerDetailsModel.fromJson(e))).toList();
    }
    else{
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<PlayerProfileModel>> getPlayerProfileSearch(PlayerProfileSearchParameters parameter) async{
    final response = await DioConfig.getData(path: ApiConstant.searchPlayer(parameter.name));
    if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    } else if (response.statusCode == 200) {
      debugPrint('playerDetails');
      return List<PlayerProfileModel>.from((response.data['response'] as List).map((e) => PlayerProfileModel.fromJson(e))).toList();
    }
    else{
      throw ServerException(
        serverMessage: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

}


//
// class AuthInterceptor extends InterceptorsWrapper{  // add logic to request or response or error
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // Add token or authentication headers here
//     options.headers={
//       'Authorization': 'Bearer token'
//     };
//     super.onRequest(options, handler);
//     //handle request
//     handler.next(options);
//   }
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print(response.data);
//     super.onResponse(response, handler);
//     handler.next(response);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     print('Error: ${err.message}');
//     super.onError(err, handler);
//     handler.next(err);
//   }
// }
