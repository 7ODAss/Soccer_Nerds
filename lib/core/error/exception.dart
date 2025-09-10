import '../network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel serverMessage;
  ServerException({required this.serverMessage});
}