import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scholar/core/feature_signup/data/signup_api.dart';
import 'package:scholar/helper/show_message.dart';

import '../../../feature_login/data/login_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {

    on<SignUpInit>((event, emit) {
      emit(SignUpInitial());
    });

    on<SignUpCall>((event, emit) async {
      emit(Loading());

      final response = await SignUpApi.signup(
        event.context,
        event.name,
        event.email,
        event.password,
        event.role,
      );

      if (response.status == "failed") {
        showMessage(event.context, "فشل عملية التسجيل", true);
        emit(SignUpFailed());

      } else if (response.statusCode == 500) {
        showMessage(event.context, "نوع المستخدم غير موجود", true);
        emit(SignUpFailed());

      } else if (response.statusCode == 400) {
        showMessage(event.context, "يوجد هذا الإيميل مسبقاً", true);
        emit(SignUpFailed());

      } else if (response.status == "success") {
        showMessage(event.context, "نجحت عملية التسجيل", false);
        emit(SignUpDone(response));
      }
    });
  }
}