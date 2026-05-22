import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodninga/core/backendpoint.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/admin/domain/repositoris/storeg_repo.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_state.dart';
import 'package:image_picker/image_picker.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit({required this.storegRepo}) : super(AdminInitial());
  final StoregRepo storegRepo;
  File? selectedProductImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedProductImage = File(image.path);
      emit(ProductImagePickedState());
    }
  }

  Future addproduct({
    required String name,
    required String descreption,
    required double price,
    required String category,
  }) async {
    emit(AdminLoading());

    final result = await storegRepo.addproduct(
      ProductEntite(
        name: name,
        descreption: descreption,
        price: price,
        imageurl: '',
        id: '',
        category: category,
      ),
      selectedProductImage!,
    );

    result.fold(
      (failure) => emit(AdminError(message: failure.message)),
      (r) => emit(AdminSuccess()),
    );
  }

  List<ProductEntite> productsList = [];
  Future getproducts() async {
    emit(AdminLoading());
    final result = await storegRepo.getproducts(
      collectionPath: BackendPoint.productsCollection,
    );
    result.fold((failure) => emit(AdminError(message: failure.message)), (r) {
      productsList = r;
      emit(AdminSuccess());
    });
  }

  Future deleteproduct({
    required String imageUrl,
    required String productId,
  }) async {
    emit(AdminLoading());
    final result = await storegRepo.deleteproduct(
      imageUrl: imageUrl,
      productId: productId,
    );
    result.fold((failure) => emit(AdminError(message: failure.message)), (r) {
      emit(AdminSuccess());
      getproducts();
    });
  }
}
