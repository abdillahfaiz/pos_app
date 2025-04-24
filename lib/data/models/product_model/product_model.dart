import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final int? stock;
  final dynamic image;
  final int? favorite;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.image,
    this.favorite,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
    id: data['id'] as int?,
    name: data['name'] as String?,
    description: data['description'] as String?,
    price: data['price'] as int?,
    stock: data['stock'] as int?,
    image: data['image'] as dynamic,
    favorite: data['favorite'] as int?,
    status: data['status'] as String?,
    createdAt:
        data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
    updatedAt:
        data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'stock': stock,
    'image': image,
    'favorite': favorite,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? stock,
    dynamic image,
    int? favorite,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      stock,
      image,
      favorite,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
