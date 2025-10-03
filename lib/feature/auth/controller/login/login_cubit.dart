import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/data/remote_data/auth_api.dart';
import 'package:cartzy_app/core/model/request/login_reuest.dart';
import 'package:meta/meta.dart';

import '../../../../core/storage_helper/app_shared_preference_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    //Loading
    emit(LoginLoading());
    //Success
    try {
    var response=await  AuthApi.login(LoginRequest(
        email: email,
        password: password,
      ));
    SharedPreferencesHelper.saveData(key: 'accessToken', value: response.accessToken.toString());
    SharedPreferencesHelper.saveData(key: 'refreshToken', value: response.refreshToken.toString());

      emit(LoginSuccess());
    }
    //Error
    catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
