part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangeScreenEvent extends HomeEvent {
  final int index;
  const ChangeScreenEvent(this.index);
  @override
  List<Object?> get props => [index];
}
