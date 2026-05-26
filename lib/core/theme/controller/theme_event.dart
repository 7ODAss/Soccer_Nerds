part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  final bool? fromShared;
  const ChangeThemeEvent({this.fromShared});
  @override
  List<Object?> get props => [fromShared];
}
