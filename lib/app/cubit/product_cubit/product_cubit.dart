import 'package:bloc/bloc.dart';
import 'package:pos_app/app/cubit/product_cubit/product_state.dart';
import 'package:pos_app/data/datasource/service/product_service.dart';
import 'package:pos_app/data/models/delete_product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState());

  Future<void> getAllProduct() async {
    emit(state.copyWith(isLoading: true));

    var data = await ProductService().getAllProduct();

    data.fold(
      (left) {
        emit(state.copyWith(error: left));
      },
      (right) {
        // Jika mau ditampilkan data berdasarkan createdAt terbaru
        var reversedData = right.reversed;
        var data = reversedData.toList();
        emit(state.copyWith(productData: data));

        // emit(state.copyWith(productData: right));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required int price,
    required int stock,
  }) async {
    emit(state.copyWith(isLoading: true));

    var data = await ProductService().createProduct(
      name,
      description,
      price,
      stock,
    );

    data.fold(
      (left) => emit(state.copyWith(createError: left)),
      (right) => emit(state.copyWith(createSucces: right)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetState() {
    emit(ProductState());
  }

  Future<void> deleteProduct(int id) async {
    emit(state.copyWith(isLoading: true));

    var data = await ProductService().deleteProduct(id);

    data.fold(
      (left) => emit(state.copyWith(error: left)),
      (right) => emit(state.copyWith(deleteSucces: right)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void resetDeleteState() {
    emit(state.copyWith(deleteSucces: DeleteProductModel()));
  }
}
