import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateProductSuccesModel extends Equatable {
  final bool? status;
  final String? message;

  const CreateProductSuccesModel({this.status, this.message});

  factory CreateProductSuccesModel.fromMap(Map<String, dynamic> data) {
    return CreateProductSuccesModel(
      status: data['status'] as bool?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateProductSuccesModel].
  factory CreateProductSuccesModel.fromJson(String data) {
    return CreateProductSuccesModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [CreateProductSuccesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CreateProductSuccesModel copyWith({bool? status, String? message}) {
    return CreateProductSuccesModel(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
