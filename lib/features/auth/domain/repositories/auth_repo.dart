import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email});
  Future<Either<Failure, void>> deleteUserAccount();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
