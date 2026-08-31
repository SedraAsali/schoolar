

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/data/data_report/report_api.dart';
import 'package:scholar/core/feature_user_profile/data/data_report/report_model.dart';
import '../../../../helper/global_variable_provide.dart';
import '../../../../helper/show_message.dart';
part 'report_event.dart';
part 'report_state.dart';

class ReportViewBloc extends Bloc<ReportViewEvent, ReportViewState> {
  ReportViewBloc() : super(ReportInitial()) {
    on<AddReportEvent>((event, emit) async {

      print("Report Bloc -> Event received");

      // ==========================================
      // 1. Internet
      // ==========================================

      final connectivityResult =
      await Connectivity().checkConnectivity();

      final hasInternet =
          connectivityResult.contains(
            ConnectivityResult.mobile,
          ) ||
              connectivityResult.contains(
                ConnectivityResult.wifi,
              ) ||
              connectivityResult.contains(
                ConnectivityResult.ethernet,
              );

      if (!hasInternet) {

        print("Report -> No Internet");

        showMessage(
          event.context,
          "تحقق من اتصال الإنترنت",
          true,
        );

        emit(
          ReportNoInternetState(),
        );

        return;
      }

      // ==========================================
      // 2. User
      // ==========================================

      final configClass =
          Provider.of<GlobalVariableProvider>(
            event.context,
            listen: false,
          ).configClass;

      final userId =
          configClass?.userLogin?.user?.id;

      print("Report -> userId = $userId");

      if (userId == null) {

        showMessage(
          event.context,
          "يجب تسجيل الدخول لإرسال البلاغ",
          true,
        );

        emit(
          const ReportUnauthorizedState(
            message: "User ID is null",
          ),
        );

        return;
      }

      // ==========================================
      // 3. Loading
      // ==========================================

      emit(
        ReportLoadingState(),
      );

      try {

        // ==========================================
        // 4. API
        // ==========================================

        final ReportModel reportModel =
        await ReportApi.addReport(
          event.context,
          title: event.title,
          description: event.description,
          type: event.type,
          academyId: event.academyId,
        );

        print(
          "Report -> statusCode = "
              "${reportModel.statusCode}",
        );

        print(
          "Report -> message = "
              "${reportModel.message}",
        );

        // ==========================================
        // 5. SUCCESS 201
        // ==========================================

        if (reportModel.statusCode == 201) {

          print("Report -> SUCCESS");

          showMessage(
            event.context,
            reportModel.message ??
                "تم إرسال البلاغ بنجاح",
            false,
          );

          emit(
            ReportSuccessState(
              reportModel: reportModel,
            ),
          );

          return;
        }

        // ==========================================
        // 6. 400
        // ==========================================

        if (reportModel.statusCode == 400) {

          print("Report -> 400");

          showMessage(
            event.context,
            reportModel.message ??
                "البيانات المدخلة غير صحيحة",
            true,
          );

          emit(
            ReportErrorState(
              message: reportModel.message,
            ),
          );

          return;
        }

        // ==========================================
        // 7. 401
        // ==========================================

        if (reportModel.statusCode == 401) {

          print("Report -> 401");

          showMessage(
            event.context,
            "يجب تسجيل الدخول لإرسال البلاغ",
            true,
          );

          emit(
            ReportUnauthorizedState(
              message: reportModel.message,
            ),
          );

          return;
        }

        // ==========================================
        // 8.Other
        // ==========================================

        print("Report -> Other Error");

        showMessage(
          event.context,
          reportModel.message ??
              "حدث خطأ، حاول مرة أخرى",
          true,
        );

        emit(
          ReportErrorState(
            message: reportModel.message,
          ),
        );
      }

      // ==========================================
      // 9. Socket
      // ==========================================

      on SocketException {

        print(
          "Report -> SocketException",
        );

        showMessage(
          event.context,
          "لا يوجد اتصال بالإنترنت",
          true,
        );

        emit(
          ReportNoInternetState(),
        );
      }

      // ==========================================
      // 10. Timeout
      // ==========================================

      on TimeoutException {

        print(
          "Report -> TimeoutException",
        );

        showMessage(
          event.context,
          "انتهت مهلة الاتصال بالخادم",
          true,
        );

        emit(
          const ReportErrorState(
            message: "Timeout",
          ),
        );
      }

      // ==========================================
      // 11. Error
      // ==========================================

      catch (e) {

        print(
          "Report Bloc Error => $e",
        );

        showMessage(
          event.context,
          "حدث خطأ أثناء إرسال البلاغ",
          true,
        );

        emit(
          ReportErrorState(
            message: e.toString(),
          ),
        );
      }
    });
  } }
