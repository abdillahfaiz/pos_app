import 'package:bloc/bloc.dart';
import 'package:pos_app/app/cubit/auth_cubit/auth_state.dart';
import 'package:pos_app/data/datasource/local_storage/local_storage.dart';
import 'package:pos_app/data/datasource/service/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> doLogin(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    var data = await AuthService().login(email, password);

    data.fold(
      (left) => emit(state.copyWith(error: left)), 
      (right) {
      emit(state.copyWith(loginResponse: right));
      LocalStorage().saveToken(right.token ?? '');
    });

    emit(state.copyWith(isLoading: false));
  }
}
