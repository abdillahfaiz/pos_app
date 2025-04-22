import 'package:dio/dio.dart';
import 'package:pos_app/data/datasource/local_storage/local_storage.dart';

class ProductService {
  final dio = Dio(
    BaseOptions(
      headers: {'Authorization': LocalStorage().getToken()}
    ),
  );

  



}
