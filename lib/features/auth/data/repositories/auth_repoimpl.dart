import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foodninga/core/backendpoint.dart';
import 'package:foodninga/core/errors/exceptions.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/core/services/database_services.dart';
import 'package:foodninga/features/auth/data/datasources/firebaseauthservices.dart';
import 'package:foodninga/features/auth/data/models/user_model.dart';
import 'package:foodninga/features/auth/domain/entities/user_entity.dart';
import 'package:foodninga/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  final DatabaseServices databaseServices;

  AuthRepoImpl({
    required this.firebaseAuthServices,
    required this.databaseServices,
  });
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userData = UserModel(
        uid: user.uid,
        email: email,
        name: name,
        phone: phone,
      ).toMap();
      await databaseServices.addData(
        collectionPath: BackendPoint.usersCollection,
        data: userData,
        documentId: user.uid,
      );

      return right(user);
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userexist = await databaseServices.getData(
        collectionPath: BackendPoint.usersCollection,
        documentId: user.uid,
      );
      if (userexist == null) {
        final newUserMap = UserModel.fromEntity(user).toMap();
        await databaseServices.addData(
          collectionPath: BackendPoint.usersCollection,
          data: newUserMap,
          documentId: user.uid,
        );
        String userJson = jsonEncode(newUserMap);
        await CacheHelper.saveData(key: 'user_data', value: userJson);
        return right(user);
      } else {
        await CacheHelper.saveData(
          key: 'user_data',
          value: jsonEncode(userexist),
        );
        final user = UserModel.fromMap(userexist);
        return right(user);
      }
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuthServices.signOut();
      return right(null);
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userEntity = await firebaseAuthServices.signInWithGoogle();
      final userexist = await databaseServices.getData(
        collectionPath: BackendPoint.usersCollection,
        documentId: userEntity.uid,
      );
      if (userexist == null) {
        final newUserMap = UserModel.fromEntity(userEntity).toMap();
        await databaseServices.addData(
          collectionPath: BackendPoint.usersCollection,
          data: newUserMap,
          documentId: userEntity.uid,
        );
        String userJson = jsonEncode(newUserMap);
        await CacheHelper.saveData(key: 'user_data', value: userJson);

        return right(userEntity);
      } else {
        final user = UserModel.fromMap(userexist);
        return right(user);
      }
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await firebaseAuthServices.sendPasswordResetEmail(email: email);
      return right(null);
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserAccount() async {
    try {
      final uid = firebaseAuthServices.getCurrentUserUid();
      if (uid != null) {
        await databaseServices.deleteData(
          collectionPath: BackendPoint.usersCollection,
          documentId: uid,
        );
        await firebaseAuthServices.deleteAccount();
      }
      return right(null);
    } on AuthException catch (e) {
      return left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final uid = firebaseAuthServices.getCurrentUserUid();
      if (uid != null) {
        final data = await databaseServices.getData(
          collectionPath: BackendPoint.usersCollection,
          documentId: uid,
        );
        if (data != null) {
          await CacheHelper.saveData(key: 'user_data', value: jsonEncode(data));
          return right(UserModel.fromMap(data));
        }
      }
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
