import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:pos_app/data/models/login_response_model/login_response_model.dart';

class AuthService {
  final dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));

  Future<Either<String, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      var response = await dio.post(
        'http://10.0.2.2:8000/api/login',
        data: {"email": email, "password": password},
      );

      var dataResponse = LoginResponseModel.fromMap(response.data);
      return Right(dataResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else {
        return Left('Undhandle Error : ${e.message}');
      }
    }
  }
}
