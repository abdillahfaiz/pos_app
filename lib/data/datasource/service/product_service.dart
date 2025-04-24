import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:pos_app/data/datasource/local_storage/local_storage.dart';
import 'package:pos_app/data/models/create_product_error_model/create_product_error_model.dart';
import 'package:pos_app/data/models/create_product_succes_model.dart';
import 'package:pos_app/data/models/product_model/product_model.dart';

class ProductService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {'Authorization': 'Bearer ${LocalStorage().getToken()}'},
    ),
  );

  Future<Either<String, List<ProductModel>>> getAllProduct() async {
    try {
      var response = await dio.get('/product');

      var data =
          (response.data as List)
              .map((item) => ProductModel.fromMap(item))
              .toList();

      return Right(data);
    } catch (e) {
      return Left('Gagal mengambil data product');
    }
  }

  Future<Either<CreateProductErrorModel, CreateProductSuccesModel>>
  createProduct(String name, String description, int price, int stock) async {
    try {
      var response = await dio.post(
        '/product',
        data: {
          "name": name,
          "description": description,
          "price": price,
          "stock": stock,
        },
      );

      var data = CreateProductSuccesModel.fromMap(response.data);
      return Right(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        var error = CreateProductErrorModel.fromMap(e.response?.data);
        return Left(error);
      } else {
        return Left(CreateProductErrorModel(message: 'Error ${e.message}'));
      }
    }
  }
}
