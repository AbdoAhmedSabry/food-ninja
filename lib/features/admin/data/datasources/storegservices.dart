import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foodninga/core/errors/exceptions.dart';

class StorageServices {
  final _supabase = Supabase.instance.client;
  final String _bucketName = 'products_images';

  Future<String> uploadImage({required File imageFile}) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imagePath = 'products/$fileName';

      await _supabase.storage.from(_bucketName).upload(imagePath, imageFile);
      final imageUrl = _supabase.storage
          .from(_bucketName)
          .getPublicUrl(imagePath);

      return imageUrl;
    } catch (e) {
      throw ServerException(message: 'Failed to upload image: ${e.toString()}');
    }
  }

  Future<void> deleteImage({required String imageUrl}) async {
    try {
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final imagePath =
          '${pathSegments[pathSegments.length - 2]}/${pathSegments.last}';

      await _supabase.storage.from(_bucketName).remove([imagePath]);
    } catch (e) {
      throw ServerException(message: 'Failed to delete image: ${e.toString()}');
    }
  }
}
