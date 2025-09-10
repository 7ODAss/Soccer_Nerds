import 'package:football_app/core/theme/controller/theme_bloc.dart';
import 'package:football_app/features/home/presentation/controller/home_bloc.dart';
import 'package:football_app/features/leagues/data/datasource/standing_league_remote_datasource.dart';
import 'package:football_app/features/leagues/domain/repo/base_standing_league_repo.dart';
import 'package:football_app/features/leagues/domain/usecase/get_league_usecase.dart';
import 'package:football_app/features/leagues/presentation/controller/standing_bloc.dart';
import 'package:football_app/features/list_of_match/data/datasource/match_remote_datasource.dart';
import 'package:football_app/features/list_of_match/data/repo/match_repo.dart';
import 'package:football_app/features/list_of_match/domain/repo/base_match_repo.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_live_match_usecase.dart';
import 'package:football_app/features/list_of_match/domain/usecase/get_match_statistics_usecase.dart';
import 'package:football_app/features/list_of_match/presentation/controller/live_match_details_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/controller/match_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/favorite/services/favorite_service.dart';
import '../../features/list_of_match/domain/usecase/get_live_match_details_usecase.dart';
import '../../features/list_of_match/domain/usecase/get_team_form_usecase.dart';
import '../../features/list_of_match/domain/usecase/get_upcoming_match_usecase.dart';

final getIt=GetIt.instance;
class ServiceLocator{
  void init(){
    getIt.registerFactory(()=>ThemeBloc());
    //favorite service
    getIt.registerLazySingleton(() => FavoriteService());
    //BLoc
    getIt.registerFactory(()=>MatchBloc(getIt(),getIt(),getIt()));
    getIt.registerFactory(()=>LiveMatchDetailsBloc(getIt(),getIt(),getIt()));

    getIt.registerFactory(()=>HomeBloc());

    //dataSource
    getIt.registerLazySingleton<BaseMatchRemoteDataSource>(()=>MatchRemoteDataSource());
    //repo
    getIt.registerLazySingleton<BaseMatchRepo>(()=>MatchRepo(getIt()));
    //useCase
    getIt.registerLazySingleton(()=>GetLiveMatchUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetUpcomingMatchUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetLiveMatchDetailsUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetTeamFormUseCase(getIt()));
    getIt.registerLazySingleton(()=>GetMatchStatisticsUseCase(getIt()));


  }
}