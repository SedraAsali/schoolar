import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar/core/feature_favorites/data/delete_favorite/delete_favorite_api.dart';
import 'package:scholar/core/feature_favorites/data/delete_favorite/delete_favorite_model.dart';

import '../../../../../helper/show_message.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc
    extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  DeleteFavoriteBloc() : super(DeleteFavoriteInitial()) {
    on<DeleteFavoriteViewEvent>((event, emit) async {
      print("DeleteFavorite Event Received");

      var connectivityResult = await Connectivity().checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.mobile) &&
          !connectivityResult.contains(ConnectivityResult.wifi) &&
          !connectivityResult.contains(ConnectivityResult.ethernet)) {
        print("No Internet DeleteFavorite");

        showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(NoInternetDeleteFavoriteState());

        return;
      }

      emit(LoadingDeleteFavoriteState());

      try {
        DeleteFavoriteModel model = await DeleteFavoriteApi.deleteFavoriteApi(
          event.context,
          event.favoriteId,
        );

        print("DeleteFavorite message => ${model.message}");

        print("DeleteFavorite status => ${model.status}");

        if (model.status == "success") {
          showMessage(event.context, model.message ?? "تم الحذف بنجاح", false);

          emit(SuccessDeleteFavoriteState(deleteFavoriteModel: model));
        } else {
          showMessage(event.context, model.message ?? "حدث خطأ", true);

          emit(ErrorDeleteFavoriteState(message: model.message ?? "حدث خطأ"));
        }
      } on SocketException {
        print("DeleteFavorite SocketException");

        showMessage(event.context, "تحقق من اتصال الإنترنت", true);

        emit(NoInternetDeleteFavoriteState());
      } on TimeoutException {
        print("DeleteFavorite Timeout");

        showMessage(event.context, "انتهت مهلة الاتصال", true);

        emit(NoInternetDeleteFavoriteState());
      } catch (e, stackTrace) {
        print("DeleteFavorite Error => $e");
        print(stackTrace);

        showMessage(event.context, "حدث خطأ", true);

        emit(ErrorDeleteFavoriteState(message: e.toString()));
      }
    });
  }
}
