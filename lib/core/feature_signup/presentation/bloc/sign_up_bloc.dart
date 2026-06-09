import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scholar/core/feature_login/data/login_api.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/core/feature_signup/data/signup_api.dart';
import 'package:scholar/helper/show_message.dart' show showMessage;
import 'package:equatable/equatable.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {

    on<SignUpInit>((event, emit) {
      emit(SignUpInitial());
    });

    on<SignUpCall>((event, emit) async {
      print("SignUpBloc ");

      emit(Loading());

      final response = await SignUpApi.signup(
        event.context,
        event.name,
        event.email,
        event.password,
        event.role
      );

      if (response.status == "failed") {
        showMessage("فشل عملية الدخول", true);
        emit(SignUpFailed());
      }

      else if (response.statusCode == 500) {
        showMessage("نوع المستخدم غير موجود", true);
        emit(SignUpFailed());
      }


      else if (response.statusCode == 400) {
        showMessage("يوجد هذا الايميل مسبقا", true);
        emit(SignUpFailed());
      }
      else if (response.status == "success") {
        showMessage("نجحت عملية الدخول", true);

        emit(SignUpDone(response));
      }
    });

  }
}

