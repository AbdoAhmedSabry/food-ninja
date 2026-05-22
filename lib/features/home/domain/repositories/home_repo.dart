import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductEntite>>> getproducts({
    required String collectionPath,
    String? category,
  });
}
