import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/core/shared/models/productmodel.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/core/services/database_services.dart';
import 'package:foodninga/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DatabaseServices databaseServices;
  HomeRepoImpl({required this.databaseServices});
  @override
  Future<Either<Failure, List<ProductEntite>>> getproducts({
    required String collectionPath,
    String? category,
  }) async {
    try {
      final products = await databaseServices.getCollectionData(
        collectionPath: collectionPath,
        category: category,
      );
      return right(
        products.map((product) => Productmodel.fromMap(product)).toList(),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
