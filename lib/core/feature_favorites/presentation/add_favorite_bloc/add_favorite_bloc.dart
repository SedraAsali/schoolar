import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar/core/feature_favorites/data/add_favorite/add_favorite_api.dart';
import 'package:scholar/core/feature_favorites/data/add_favorite/add_favorite_model.dart';

import '../../../../helper/show_message.dart';

import '../../data/GetFavoriteApi.dart';
import '../../data/GetFavoriteModel.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  AddFavoriteBloc() : super(AddFavoriteInitial()) {
    on<AddFavoriteViewEvent>((event, emit) async {
      print("AddFavorite Event Received");

      var connectivityResult = await Connectivity().checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.mobile) &&
          !connectivityResult.contains(ConnectivityResult.wifi) &&
          !connectivityResult.contains(ConnectivityResult.ethernet))
      {
        print("No Internet AddFavorite");

        showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(NoInternetAddFavoriteState());

        return;
      }

      emit(LoadingAddFavoriteState());

      try {
        AddFavoriteModel model = await AddFavoriteApi.addFavoriteApi(
          event.context,
          event.academyId,
          event.userId,
        );

        print("AddFavorite message ${model.message}");

        // نجاح الإضافة
        if (model.favorite != null) {
          print("Add Favorite Success");

          showMessage(event.context, "تمت إضافة المعهد للمفضلة بنجاح", false);

          // تحديث المفضلة من السيرفر
          GetFavoriteModel favorites = await FavoriteApi.getFavoriteApi(
            event.context,
            event.userId,
          );

          if (favorites.data != null) {
            print("Get Favorite Updated Successfully");

            showMessage(event.context, "تم تحديث المفضلة", false);

            emit(SuccessAddFavoriteState(addFavoriteModel: model));
          } else {
            print("Get Favorite Failed");

            showMessage(
              event.context,
              "فشل تحديث المفضلة",
              true,
            );

            emit(
              ErrorAddFavoriteState(
                message: favorites.message ?? "فشل تحديث المفضلة",
              ),
            );
          }
        }
        // فشل من السيرفر
        else {
          print("Add Favorite Failed ${model.message}");

          showMessage(event.context, model.message ?? "حدث خطأ", true);

          emit(ErrorAddFavoriteState(message: model.message ?? "حدث خطأ"));
        }
      } on SocketException {
        print("AddFavorite SocketException");

        showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(NoInternetAddFavoriteState());
      } on TimeoutException {
        print("AddFavorite Timeout");

        showMessage(event.context, "انتهت مهلة الاتصال", true);

        emit(NoInternetAddFavoriteState());
      } catch (e) {
        print("AddFavorite Error $e");

        showMessage(event.context, "حدث خطأ", true);

        emit(ErrorAddFavoriteState(message: e.toString()));
      }
    });
  }
}
