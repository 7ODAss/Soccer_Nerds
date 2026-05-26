part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int index;
  const HomeState(this.index);
  @override
  List<Object?> get props => [index];
}

