import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_home/data/data_teachers/teachers_api.dart';
import 'package:scholar/core/feature_home/data/data_teachers/teachers_model.dart';

import '../../../../helper/global_variable_provide.dart';
import '../../../../helper/show_message.dart';

part 'teachers_event.dart';
part 'teachers_state.dart';

class TeachersViewBloc
    extends Bloc<TeachersViewEvent, TeachersViewState> {

  TeachersViewBloc() : super(TeachersInitial()) {

    on<LoadingTeachersViewEvent>((event, emit) async {

      print("Teachers Bloc -> Event received");

      // --------------------------------
      // 1. فحص الإنترنت
      // --------------------------------

      final connectivityResult =
      await Connectivity().checkConnectivity();

      final hasInternet =
          connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi) ||
              connectivityResult.contains(ConnectivityResult.ethernet);

      if (!hasInternet) {

        print("Teachers -> No Internet");

        showMessage(
          event.context,
          "تحقق من اتصال الإنترنت",
          true,
        );

        emit(TeachersNoInternetState());

        return;
      }

      emit(TeachersLoadingState());

      try {

        // --------------------------------
        // 2. جلب Role المستخدم
        // --------------------------------

        final configClass =
            Provider.of<GlobalVariableProvider>(
              event.context,
              listen: false,
            ).configClass;

        final role =
            configClass?.userLogin?.user?.role;

        print("Teachers -> role = $role");

        // --------------------------------
        // 3. استدعاء API
        // --------------------------------

        final TeachersModel teachersModel =
        await TeachersApi.getAllTeachers(
          event.context,
          event.academyId,
         // role: role,
        );

        print(
          "Teachers -> statusCode = ${teachersModel.statusCode}",
        );

        print(
          "Teachers -> message = ${teachersModel.message}",
        );

        // --------------------------------
        // 4. SUCCESS 200
        // --------------------------------

        if (teachersModel.statusCode == 200) {

          print("Teachers -> SUCCESS");

          emit(
            TeachersSuccessState(
              teachersModel: teachersModel,
            ),
          );

          return;
        }

        // --------------------------------
        // 5. ERROR 401
        // Manager token مع API تبع User
        // --------------------------------

        if (teachersModel.statusCode == 401) {

          print("Teachers -> 401");

          showMessage(
            event.context,
            "يجب تسجيل الدخول بحساب مستخدم",
            true,
          );

          emit(
            TeachersUnauthorizedState(
              message: teachersModel.message,
            ),
          );

          return;
        }

        // --------------------------------
        // 6. ERROR 403
        // User token مع API تبع Manager
        // --------------------------------

        if (teachersModel.statusCode == 403) {

          print("Teachers -> 403");

          showMessage(
            event.context,
            "هذه العملية متاحة للمدير فقط",
            true,
          );

          emit(
            TeachersForbiddenState(
              message: teachersModel.message,
            ),
          );

          return;
        }

        // --------------------------------
        // 7. ERROR 500
        // academyId غلط
        // --------------------------------

        if (teachersModel.statusCode == 500) {

          print("Teachers -> 500");

          showMessage(
            event.context,
            "رقم المعهد غير صحيح",
            true,
          );

          emit(
            TeachersServerErrorState(
              message: teachersModel.message,
            ),
          );

          return;
        }

        // --------------------------------
        // 8. أي خطأ آخر
        // --------------------------------

        showMessage(
          event.context,
          "حدث خطأ ما، حاول مرة أخرى",
          true,
        );

        emit(
          TeachersErrorState(
            message: teachersModel.message,
          ),
        );

      } on SocketException {

        print("Teachers -> SocketException");

        showMessage(
          event.context,
          "لا يوجد اتصال بالإنترنت",
          true,
        );

        emit(TeachersNoInternetState());

      } on TimeoutException {

        print("Teachers -> TimeoutException");

        showMessage(
          event.context,
          "انتهت مهلة الاتصال بالخادم",
          true,
        );

        emit(
          TeachersErrorState(
            message: "Timeout",
          ),
        );

      } catch (e) {

        print("Teachers Bloc Error => $e");

        showMessage(
          event.context,
          "حدث خطأ ما، حاول مرة أخرى",
          true,
        );

        emit(
          TeachersErrorState(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
