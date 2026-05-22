import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';

abstract class StoregRepo {
  Future<Either<Failure, void>> addproduct(
    ProductEntite product,
    File imageUrl,
  );
  Future<Either<Failure, void>> deleteproduct({
    required String imageUrl,
    required String productId,
  });
  Future<Either<Failure, List<ProductEntite>>> getproducts({
    required String collectionPath,
  });
}
