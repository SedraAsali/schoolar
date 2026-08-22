import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scholar/core/feature_home/data/data_rating/rating_api.dart';
import 'package:scholar/core/feature_home/data/data_rating/rating_model.dart';

import '../../../../helper/global_variable_provide.dart';
import '../../../../helper/show_message.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingViewBloc extends Bloc<RatingViewEvent, RatingViewState> {
  RatingViewBloc() : super(RatingInitial()) {
    on<AddRatingEvent>((event, emit) async {
      print("Rating Bloc -> Event received");

      // ==========================================
      // 1. فحص الإنترنت
      // ==========================================

      final connectivityResult = await Connectivity().checkConnectivity();

      final hasInternet =
          connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet);

      if (!hasInternet) {
        print("Rating -> No Internet");

        showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(RatingNoInternetState());

        return;
      }

      // ==========================================
      // 2. التأكد من تسجيل الدخول
      // ==========================================

      final configClass = Provider.of<GlobalVariableProvider>(
        event.context,
        listen: false,
      ).configClass;

      final userId = configClass?.userLogin?.user?.id;

      print("Rating -> userId = $userId");
      print("Rating -> academyId = ${event.academyId}");
      print("Rating -> rating = ${event.rating}");

      if (userId == null) {
        showMessage(event.context, "يجب تسجيل الدخول لتقييم المعهد", true);

        emit(RatingUnauthorizedState(message: "User ID is null"));

        return;
      }

      // ==========================================
      // 3. Loading
      // ==========================================

      emit(RatingLoadingState());

      try {
        // ==========================================
        // 4. API
        // ==========================================

        final RatingModel ratingModel = await RatingApi.addRating(
          event.context,
          event.academyId,
          event.rating,
        );

        print(
          "Rating -> statusCode = "
          "${ratingModel.statusCode}",
        );

        print(
          "Rating -> status = "
          "${ratingModel.status}",
        );

        print(
          "Rating -> message = "
          "${ratingModel.message}",
        );

        // ==========================================
        // 5. SUCCESS
        // ==========================================

        if (ratingModel.statusCode == 200 && ratingModel.status == "success") {
          print("Rating -> SUCCESS");

          emit(RatingSuccessState(ratingModel: ratingModel));

          return;
        }

        // ==========================================
        // 6. 401
        // ==========================================

        if (ratingModel.statusCode == 401) {
          print("Rating -> 401");

          showMessage(event.context, "يجب تسجيل الدخول لتقييم المعهد", true);

          emit(RatingUnauthorizedState(message: ratingModel.message));

          return;
        }

        // ==========================================
        // 7.Backend Error
        // ==========================================

        print("Rating -> Backend Error");

        showMessage(
          event.context,
          ratingModel.message ?? "حدث خطأ أثناء إرسال التقييم",
          true,
        );

        emit(RatingErrorState(message: ratingModel.message));
      }
      // ==========================================
      // 8. SocketException
      // ==========================================
      on SocketException {
        print("Rating -> SocketException");

        showMessage(event.context, "لا يوجد اتصال بالإنترنت", true);

        emit(RatingNoInternetState());
      }
      // ==========================================
      // 9. Timeout
      // ==========================================
      on TimeoutException {
        print("Rating -> TimeoutException");

        showMessage(event.context, "انتهت مهلة الاتصال بالخادم", true);

        emit(RatingErrorState(message: "Timeout"));
      }
      // ==========================================
      // 10. أي Exception
      // ==========================================
      catch (e) {
        print("Rating Bloc Error => $e");

        showMessage(event.context, "حدث خطأ أثناء إرسال التقييم", true);

        emit(RatingErrorState(message: e.toString()));
      }
    });
  }
}
