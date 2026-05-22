import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodninga/core/errors/exceptions.dart';

abstract class DatabaseServices {
  Future<void> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  });
  Future<void> deleteData({
    required String collectionPath,
    required String documentId,
  });
  Future<Map<String, dynamic>?> getData({
    required String collectionPath,
    required String documentId,
  });
  Future<List<Map<String, dynamic>>> getCollectionData({
    required String collectionPath,
    String? category,
  });
}

class DatabaseServicesImpl implements DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore.collection(collectionPath).doc(documentId).set(data);
      } else {
        await _firestore.collection(collectionPath).add(data);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteData({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> getData({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final doc = await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .get();
      return doc.data();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getCollectionData({
    required String collectionPath,
    String? category,
  }) async {
    try {
      Query query = _firestore.collection(collectionPath);

      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
