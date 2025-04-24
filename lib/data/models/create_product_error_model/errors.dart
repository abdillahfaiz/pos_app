import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String>? name;
  final List<String>? price;
  final List<String>? stock;

  const Errors({this.name, this.price, this.stock});

  factory Errors.fromMap(Map<String, dynamic> data) => Errors(
    name: data['name'] as List<String>?,
    price: data['price'] as List<String>?,
    stock: data['stock'] as List<String>?,
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'price': price,
    'stock': stock,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Errors].
  factory Errors.fromJson(String data) {
    return Errors.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Errors] to a JSON string.
  String toJson() => json.encode(toMap());

  Errors copyWith({
    List<String>? name,
    List<String>? price,
    List<String>? stock,
  }) {
    return Errors(
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, price, stock];
}
