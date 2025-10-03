import 'package:bloc/bloc.dart';
import 'package:cartzy_app/core/data/remote_data/profile_api.dart';
import 'package:cartzy_app/core/model/response/user_response.dart';
import 'package:meta/meta.dart';

import '../../../core/model/request/update_user_request.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserResponse user=UserResponse();
  Future<void> getDataProfile(String accessToken)async{
    //Loading
    emit(GetProfileLoading());
    //Success
    try{
     user=await ProfileApi.getProfileData(accessToken);
      emit(GetProfileSuccess());
    }
    //Error
    catch(e){
      emit(GetProfileError(e.toString()));
    }
  }
  Future<void> updateProfile(UpdateUserRequest request, String id)async{
    //Loading
    emit(UpdateProfileLoading());
    //Success
    try{
      user=await ProfileApi.updateProfile(request, user.id.toString());
      emit(UpdateProfileSuccess());
    }
    //Error
    catch(e){
      emit(UpdateProfileError(e.toString()));
    }
  }
}
