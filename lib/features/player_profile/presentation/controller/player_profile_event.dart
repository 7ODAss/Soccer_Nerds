import 'package:equatable/equatable.dart';

abstract class PlayerProfileEvent extends Equatable {
  const PlayerProfileEvent();
  @override
  List<Object?> get props =>[];
}


class GetPlayerProfileEvent extends PlayerProfileEvent {
  final int page;
  const GetPlayerProfileEvent(this.page);
  @override
  List<Object?> get props => [page];
}

class GetPlayerDetailsEvent extends PlayerProfileEvent {
  final int id;
  const GetPlayerDetailsEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class ChangeScreenEvent extends PlayerProfileEvent {
  final int pageIndex;
  const ChangeScreenEvent(this.pageIndex);
  @override
  List<Object> get props => [pageIndex];
}

class GetPlayerProfileSearchEvent extends PlayerProfileEvent {
  final String name;
  const GetPlayerProfileSearchEvent(this.name);
  @override
  List<Object?> get props => [name];
}

