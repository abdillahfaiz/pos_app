// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:pos_app/data/models/create_product_error_model/create_product_error_model.dart';
import 'package:pos_app/data/models/create_product_succes_model.dart';
import 'package:pos_app/data/models/product_model/product_model.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productData = const [],
    this.createError = const CreateProductErrorModel(),
    this.createSucces = const CreateProductSuccesModel(),
    this.isLoading = false,
    this.error = '',
  });

  final List<ProductModel> productData;
  final CreateProductSuccesModel createSucces;
  final CreateProductErrorModel createError;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [productData, isLoading, error, createError, createSucces];

  ProductState copyWith({
    List<ProductModel>? productData,
    CreateProductSuccesModel? createSucces,
    CreateProductErrorModel? createError,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      productData: productData ?? this.productData,
      createSucces: createSucces ?? this.createSucces,
      createError: createError ?? this.createError,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
