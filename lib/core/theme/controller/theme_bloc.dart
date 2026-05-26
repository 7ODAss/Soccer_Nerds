import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../network/local/cache_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDark: false)) {
    on<ChangeThemeEvent>(changeTheme);
  }

  Future<void> changeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    if(event.fromShared != null){
      emit(ThemeState(isDark: event.fromShared!));
    }
    else{
      final newIsDark = !state.isDark;
      await CacheHelper.setData(key: 'isDark', value: newIsDark).then((value) {
        emit(ThemeState(isDark: newIsDark));
      });
    }
  }
}
