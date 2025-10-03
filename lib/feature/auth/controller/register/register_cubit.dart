import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/data/remote_data/auth_api.dart';
import 'package:cartzy_app/core/model/request/register_request.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    //Loading
    emit(RegisterLoading());
    //Success
    try {
      await AuthApi.register(RegisterRequset(
        name: name,
        email: email,
        password: password,
      ));
      emit(RegisterSuccess());
    }
    //Error
    catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
