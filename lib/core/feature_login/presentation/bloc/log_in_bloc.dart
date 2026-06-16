import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scholar/core/feature_login/data/login_api.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/helper/show_message.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {

    on<LogInInit>((event, emit) {
      emit(LogInInitial());
    });

    on<LogInCall>((event, emit) async {
      emit(Loading());

      final response = await LogInApi.login(
        event.context,
        event.email,
        event.password,
      );
      print("heyyyyyyyyyyyyyyy ${response.statusCode}");
      if (response.status == "failed") {
        showMessage(event.context, "فشل عملية الدخول",
        true
        );
        emit(LogInFailed());

      } else if (response.statusCode == 401) {
        showMessage(event.context, "اسم مستخدم أو كلمة مرور خاطئة",
        true);
        emit(LogInFailed());

      } else if (response.statusCode == 404) {
        showMessage(event.context, "البريد مسجل مسبقاً",true);
        emit(LogInFailed());

      } else if (response.statusCode == 400) {
        showMessage(event.context, "انتهت صلاحية الرابط",true);
        emit(LogInFailed());

      } else if (response.status == "success") {
        showMessage(event.context, "نجحت عملية الدخول",false);
        emit(LogInDone(response));
      }
    });
  }
}