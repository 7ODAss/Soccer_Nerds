import 'package:football_app/core/theme/controller/theme_bloc.dart';
import 'package:football_app/features/home/presentation/controller/home_bloc.dart';
import 'package:football_app/features/list_of_match/data/datasource/match_remote_datasource.dart';
import 'package:football_app/features/list_of_match/data/repo/match_repo.dart';
import 'package:football_app/features/list_of_match/domain/repo/base_match_repo.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_live_match_usecase.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_match_statistics_usecase.dart';
import 'package:football_app/features/list_of_match/presentation/controller/live_match_details_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/controller/match_bloc.dart';
import 'package:football_app/features/player_profile/data/datasource/player_profile_remote_datasource.dart';
import 'package:football_app/features/player_profile/domain/repo/base_player_profile_repo.dart';
import 'package:football_app/features/player_profile/domain/usecase/get_player_profile_usecase.dart';
import 'package:football_app/features/player_profile/presentation/controller/player_profile_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/ai/service/aianalystservice.dart';
import '../../features/favorite/services/favorite_service.dart';
import '../../features/list_of_match/domain/usecase/get_live_match_details_usecase.dart';
import '../../features/list_of_match/domain/usecase/get_team_form_usecase.dart';
import '../../features/list_of_match/domain/usecase/get_upcoming_match_usecase.dart';
import '../../features/player_profile/data/repo/player_profile_repo.dart';
import '../../features/player_profile/domain/usecase/get_player_details_usecase.dart';
import '../../features/player_profile/domain/usecase/get_player_profile_search_usecase.dart';

final getIt=GetIt.instance;
class ServiceLocator{
  void init(){
    getIt.registerFactory(()=>ThemeBloc());
    //favorite service
    getIt.registerLazySingleton(() => FavoriteService());
    //Ai
    getIt.registerLazySingleton(() => AiAnalystService());
    //BLoc
    getIt.registerFactory(()=>MatchBloc(getIt(),getIt(),getIt()));
    getIt.registerFactory(()=>LiveMatchDetailsBloc(getIt(),getIt(),getIt()));
    getIt.registerFactory(()=>PlayerProfileBloc(getIt(),getIt(),getIt()));

    getIt.registerFactory(()=>HomeBloc());

    //dataSource
    getIt.registerLazySingleton<BaseMatchRemoteDataSource>(()=>MatchRemoteDataSource());
    getIt.registerLazySingleton<BasePlayerProfileRemoteDataSource>(()=>PlayerProfileRemoteDataSource());
    //repo
    getIt.registerLazySingleton<BaseMatchRepo>(()=>MatchRepo(getIt()));
    getIt.registerLazySingleton<BasePlayerProfileRepo>(()=>PlayerProfileRepo(getIt()));
    //useCase
    getIt.registerLazySingleton(()=>GetLiveMatchUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetUpcomingMatchUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetLiveMatchDetailsUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetTeamFormUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetMatchStatisticsUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetPlayerProfileUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetPlayerDetailsUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetPlayerProfileSearchUseCase(getIt()));
  }
}