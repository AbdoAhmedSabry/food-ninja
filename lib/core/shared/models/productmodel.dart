import 'package:foodninga/core/shared/entities/product_entite.dart';

class Productmodel extends ProductEntite {
  Productmodel({
    required super.name,
    required super.descreption,
    required super.imageurl,
    required super.price,
    required super.id,
    required super.category,
  });

  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'name': name,
      'description': descreption,
      'price': price,
      'imageurl': imageurl,
      'category': category,
    };
  }

  factory Productmodel.fromMap(Map<String, dynamic> map, [String? docId]) {
    return Productmodel(
      id: docId ?? map['id'] ?? '',

      name: map['name'] ?? '',
      category: map['category'] ?? '',
      descreption: map['descripition'] ?? '',

      imageurl: map['imageurl'] ?? '',

      price: map['price'] ?? '0',
    );
  }
}
