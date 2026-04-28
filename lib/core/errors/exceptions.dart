class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class AuthException extends ServerException {
  AuthException({required super.message});
}

class NetworkException implements Exception {}
