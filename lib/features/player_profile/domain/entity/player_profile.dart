import 'package:equatable/equatable.dart';

class PlayerProfile extends Equatable {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final int age;
  final String nationality;
  final int number;
  final String position;
  final String height;
  final String weight;
  final String photo;


  const PlayerProfile({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.nationality,
    required this.number,
    required this.position,
    required this.height,
    required this.weight,
    required this.photo,
  });

  @override
  List<Object?> get props => [id, name, firstName, lastName, age, nationality, number, position, height, weight, photo];
}
