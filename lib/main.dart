import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_app/core/services/service_locator.dart';
import 'package:football_app/features/list_of_match/presentation/screen/match_screen.dart';
import 'package:football_app/features/home/presentation/screen/home_screen.dart';
import 'package:football_app/features/splash/splash_screen.dart';

import 'core/network/local/cache_helper.dart';
import 'core/theme/controller/theme_bloc.dart';
import 'core/theme/theme_mode.dart';
import 'features/favorite/services/favorite_service.dart';
import 'features/home/presentation/controller/home_bloc.dart';
import 'features/list_of_match/presentation/controller/match_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  ServiceLocator().init();
  await getIt<FavoriteService>().init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark: isDark ?? false));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
          getIt<ThemeBloc>()..add(ChangeThemeEvent(fromShared: isDark)),
        ),
        BlocProvider(create: (BuildContext context) => getIt<HomeBloc>()),
        BlocProvider(
          create: (BuildContext context) => getIt<MatchBloc>()
            ..add(GetLiveMatchEvent())
            ..add(
              GetUpcomingMatchEvent(
                date: DateTime.now()
                    .add(const Duration(days: 1))
                    .toIso8601String()
                    .split('T')
                    .first,
              ),
            )
            ..add(LoadFavoritesEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.isDark ? getDarkMode() : getLightMode(),
            home: SplashScreen(),
          );
        },
      ), // Use a wrapper widget
    );
  }
}