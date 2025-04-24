// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:pos_app/data/models/login_error_model.dart';
import 'package:pos_app/data/models/login_response_model/login_response_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginResponse = const LoginResponseModel(),
    this.isLoading = false,
    this.error = '',
  });

  final LoginResponseModel loginResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object> get props => [loginResponse, isLoading, error];

  AuthState copyWith({
    LoginResponseModel? loginResponse,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      loginResponse: loginResponse ?? this.loginResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
