import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scholar/core/feature_login/data/login_api.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/helper/show_message.dart' show showMessage;
import 'package:equatable/equatable.dart';


part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {

    on<LogInInit>((event, emit) {
      emit(LogInInitial());
    });

    on<LogInCall>((event, emit) async {
      print("LogInBloc ");

      emit(Loading());

      final response = await LogInApi.login(
        event.context,
        event.email,
        event.password,
      );

      if (response.status == "failed") {
        showMessage("فشل عملية الدخول", true);
        emit(LogInFailed());
      }

      else if (response.status == "notAuth") {
        showMessage("اسم مستخدم أو كلمة مرور خاطئة", true);
        emit(LogInFailed());
      }

      else if (response.status == "shortPassword") {
        showMessage("كلمة المرور قصيرة", true);
        emit(LogInFailed());
      }

      else if (response.status == "success") {
        emit(LogInDone(response));
      }
    });

  }
}

