import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;

  const ErrorMessageModel({required this.message});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    final errors = json['errors'] as Map<String, dynamic>?;

    if (errors != null && errors.isNotEmpty) {
      return ErrorMessageModel(
        message: errors.entries.first.value.toString(),
      );
    }
    return const ErrorMessageModel(
      message: 'An unknown error occurred. Please try again.',
    );
  }

  @override
  List<Object?> get props => [message];
}