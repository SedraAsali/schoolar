import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/core/feature_user_profile/data/profile_api.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState>  {
  GetProfileCubit() : super(GetProfileInitial());

  getProfile(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {

      emit(ProfileFetchLoadingState());

      LogInModel userObject = await ProfileApi().getProfile(context: context);

      print("userObject.status GetProfileCubit userObject ${userObject}");
      print("userObject.status GetProfileCubit userObject.status ${userObject.status}");

      if (userObject.status == "success") {
        Provider.of<ProfileProvider>(context).initialFirstPageProfile(context, userObject);

        emit(ProfileFetchSuccessState(userObject: userObject));
      } else {
        emit(ProfileFetchFailedState());
        showMessage(context, "فشل تحديث بيانات المستخدم", false);

      }

    } else {
      emit(ProfileFetchNoInternetState());
      showMessage(context, "تحقق من اتصال الإنترنت", true);
    }
  }

}
