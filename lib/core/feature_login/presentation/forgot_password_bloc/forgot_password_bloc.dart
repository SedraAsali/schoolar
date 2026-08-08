import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scholar/core/feature_login/data/data_forgot_password/forgot_password_api.dart';
import 'package:scholar/core/feature_login/data/data_forgot_password/forgot_password_model.dart';
import 'package:scholar/helper/show_message.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEventRequest>((event, emit) async {
      // فحص الاتصال
      var connectivityResult = await Connectivity().checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.mobile) &&
          !connectivityResult.contains(ConnectivityResult.wifi) &&
          !connectivityResult.contains(ConnectivityResult.ethernet)) {
        print("No Internet forgot password bloc");

       // showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(ForgotPasswordNoInternet());
        return;
      }

      emit(ForgotPasswordLoading());
      print("ForgotPasswordLoading emitted");

      try {
        final ForgotPasswordModel response =
            await ForgotPasswordApi.forgotPassword( event.email);
        print("🔥 RESPONSE RECEIVED");
        print("🔥 RESPONSE = $response");
        print("🔥 STATUS CODE = ${response.statusCode}");
        print("🔥 BEFORE IF");
        // Email not found
        if (response.statusCode == 404) {
          // showMessage(
          //   event.context,
          //   "لا يوجد مستخدم مسجل بهذا البريد الإلكتروني",
          //   true,
          // );

          emit(ForgotPasswordNotFound());
        }
        // Bad Request
        else if (response.statusCode == 400) {
         // showMessage(event.context, "البيانات المدخلة غير صحيحة", true);

          emit(ForgotPasswordBadRequest());
        }
        // Success
        else if (response.statusCode == 200) {
          // showMessage(
          //   event.context,
          //   "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
          //   false,
          // );

          emit(ForgotPasswordDone(response));
        }
        // Other errors
        else {
          // showMessage(
          //   event.context,
          //   "حدث خطأ ما، يرجى المحاولة مرة أخرى",
          //   true,
          // );

          emit(ForgotPasswordFailed());
        }
      } on SocketException {
        print("No Internet - SocketException");
     //   showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(ForgotPasswordNoInternet());
      } on TimeoutException {
        print("Request Timeout");

        // showMessage(
        //   event.context,
        //   "تعذر الاتصال بالخادم، تحقق من اتصال الإنترنت",
        //   true,
        // );

        emit(ForgotPasswordNoInternet());
      } catch (e, stack) {
        print("ForgotPasswordBloc Error: $e");
        print("ForgotPasswordBloc stack: $stack");

     //   showMessage(event.context, "حدث خطأ ما، يرجى المحاولة مرة أخرى", true);

        emit(ForgotPasswordFailed());
      }
    });
  }
}
