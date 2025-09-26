import 'package:football_app/features/player_profile/domain/entity/player_profile.dart';

class PlayerProfileModel extends PlayerProfile {
  const PlayerProfileModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.nationality,
    required super.number,
    required super.position,
    required super.height,
    required super.weight,
    required super.photo,
  });

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) =>
      PlayerProfileModel(
        id: json['player']['id'] ?? 0,
        name: json['player']['name'] ?? 'No Name',
        firstName: json['player']['firstname'] ?? '?',
        lastName: json['player']['lastname'] ?? '?',
        age: json['player']['age'] ?? 18,
        nationality: json['player']['nationality'] ?? '?',
        number: json['player']['number'] ?? 15,
        position: json['player']['position'] ?? '?',
        height: json['player']['height'] ?? '?',
        weight: json['player']['weight'] ?? '?',
        photo: json['player']['photo'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'firstname': firstName,
    'lastname': lastName,
    'age': age,
    'nationality': nationality,
    'number': number,
    'position': position,
    'height': height,
    'weight': weight,
    'photo': photo,
  };

  factory PlayerProfileModel.fromDomain(PlayerProfile entity) {
    return PlayerProfileModel(
      id: entity.id,
      name: entity.name,
      firstName: entity.firstName,
      lastName: entity.lastName,
      age: entity.age,
      nationality: entity.nationality,
      number: entity.number,
      position: entity.position,
      height: entity.height,
      weight: entity.weight,
      photo: entity.photo,
    );
  }
}
