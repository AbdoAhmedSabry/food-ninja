import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodninga/features/auth/domain/entities/user_entity.dart';
import 'package:foodninga/features/auth/domain/repositories/auth_repo.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;

  Future<void> creatEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (UserEntity) {
        emit(AuthSuccess(user: UserEntity));
      },
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthEmailLoading());
    final result = await _authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (UserEntity) {
        emit(AuthSuccess(user: UserEntity));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthGoogleLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (UserEntity) {
        emit(AuthSuccess(user: UserEntity));
      },
    );
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(AuthLoading());
    final result = await _authRepo.sendPasswordResetEmail(email: email);
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (_) {
        emit(AuthPasswordResetEmailSent());
      },
    );
  }
}
