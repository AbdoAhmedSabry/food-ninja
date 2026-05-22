import 'package:foodninga/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess({required this.user});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class AuthPasswordResetEmailSent extends AuthState {}

class AuthEmailLoading extends AuthState {}

class AuthGoogleLoading extends AuthState {}
