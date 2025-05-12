import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeleteProductModel extends Equatable {
  final bool? status;
  final String? message;

  const DeleteProductModel({this.status, this.message});

  factory DeleteProductModel.fromMap(Map<String, dynamic> data) {
    return DeleteProductModel(
      status: data['status'] as bool?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'status': status, 'message': message};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeleteProductModel].
  factory DeleteProductModel.fromJson(String data) {
    return DeleteProductModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [DeleteProductModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DeleteProductModel copyWith({bool? status, String? message}) {
    return DeleteProductModel(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, message];
}
