// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:pos_app/data/models/create_product_error_model/create_product_error_model.dart';
import 'package:pos_app/data/models/create_product_succes_model.dart';
import 'package:pos_app/data/models/delete_product_model.dart';
import 'package:pos_app/data/models/product_model/product_model.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productData = const [],
    this.createError = const CreateProductErrorModel(),
    this.createSucces = const CreateProductSuccesModel(),
    this.deleteSucces = const DeleteProductModel(),
    this.isLoading = false,
    this.error = '',
  });

  final List<ProductModel> productData;
  final CreateProductSuccesModel createSucces;
  final CreateProductErrorModel createError;
  final DeleteProductModel deleteSucces;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [
    productData,
    isLoading,
    deleteSucces,
    error,
    createError,
    createSucces,
  ];

  ProductState copyWith({
    List<ProductModel>? productData,
    CreateProductSuccesModel? createSucces,
    CreateProductErrorModel? createError,
    DeleteProductModel? deleteSucces,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      productData: productData ?? this.productData,
      createSucces: createSucces ?? this.createSucces,
      createError: createError ?? this.createError,
      deleteSucces: deleteSucces ?? this.deleteSucces,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
