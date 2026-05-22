import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:foodninga/core/backendpoint.dart';
import 'package:foodninga/core/errors/exceptions.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/features/admin/data/datasources/storegservices.dart';
import 'package:foodninga/core/shared/models/productmodel.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/admin/domain/repositoris/storeg_repo.dart';
import 'package:foodninga/core/services/database_services.dart';

class StoregRepoImp implements StoregRepo {
  final StorageServices storageServices;
  final DatabaseServices _databaseServices;

  StoregRepoImp({
    required this.storageServices,
    required DatabaseServices databaseServices,
  }) : _databaseServices = databaseServices;

  @override
  Future<Either<Failure, void>> addproduct(
    ProductEntite product,
    File imageUrl,
  ) async {
    try {
      final imageurl = await storageServices.uploadImage(imageFile: imageUrl);
      final pro = Productmodel(
        category: product.category,
        name: product.name,
        descreption: product.descreption,
        price: product.price,
        imageurl: imageurl,
        id: product.id,
      );
      await _databaseServices.addData(
        collectionPath: BackendPoint.productsCollection,
        data: pro.tomap(),
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteproduct({
    required String imageUrl,
    required String productId,
  }) async {
    try {
      await storageServices.deleteImage(imageUrl: imageUrl);
      await _databaseServices.deleteData(
        collectionPath: BackendPoint.productsCollection,
        documentId: productId,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntite>>> getproducts({
    required String collectionPath,
  }) async {
    try {
      final data = await _databaseServices.getCollectionData(
        collectionPath: collectionPath,
      );
      final products = data.map((e) => Productmodel.fromMap(e)).toList();
      return right(products);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
