import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'errors.dart';

class CreateProductErrorModel extends Equatable {
  final String? message;
  final Errors? errors;

  const CreateProductErrorModel({this.message, this.errors});

  factory CreateProductErrorModel.fromMap(Map<String, dynamic> data) {
    return CreateProductErrorModel(
      message: data['message'] as String?,
      errors:
          data['errors'] == null
              ? null
              : Errors.fromMap(data['errors'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'message': message,
    'errors': errors?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateProductErrorModel].
  factory CreateProductErrorModel.fromJson(String data) {
    return CreateProductErrorModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [CreateProductErrorModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CreateProductErrorModel copyWith({String? message, Errors? errors}) {
    return CreateProductErrorModel(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message, errors];
}
