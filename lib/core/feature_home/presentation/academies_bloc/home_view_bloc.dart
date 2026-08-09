import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scholar/core/feature_home/data/home_view_api.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';

import '../../../../helper/show_message.dart';
part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(HomeViewInitial()) {
    print("bloc created");
    on<LoadingHomeViewEvent>((event, emit) async {
      print("event recived");
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet)) {
        emit(LoadingHomeViewState());

        try {
          HomeViewModel homeViewModel = await HomeViewApi.getAllAcademies(
            event.context,
          );

          print("HomeViewBloc homeViewModel ${homeViewModel.status}");

          if (homeViewModel.status == "success") {
            print("HomeViewBloc GetAllDataHomeViewState");
            await SharedPreferencesHelper.saveHomeAcademies(homeViewModel);
            emit(GetAllDataHomeViewState(homeViewModel: homeViewModel));
          } else {
            print("HomeViewBloc ErrorHomeViewState");

            emit(ErrorHomeViewState());
          }
        } on SocketException {
          print("HomeViewBloc SocketException");

          final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

          if (cachedHome != null &&
              cachedHome.doc != null &&
              cachedHome.doc!.isNotEmpty) {
            print("Home Cache Found after SocketException");

            emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
          } else {
            emit(NoInternetHomeViewState());
          }
        } on TimeoutException {
          print("HomeViewBloc TimeoutException");

          final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

          if (cachedHome != null &&
              cachedHome.doc != null &&
              cachedHome.doc!.isNotEmpty) {
            print("Home Cache Found after Timeout");

            emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
          } else {
            emit(NoInternetHomeViewState());
          }
        } catch (e) {
          print("HomeViewBloc Error => $e");

          final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

          if (cachedHome != null &&
              cachedHome.doc != null &&
              cachedHome.doc!.isNotEmpty) {
            print("Home Cache Found after Error");

            emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
          } else {
            emit(ErrorHomeViewState());
          }
        }
      } else {
        print("Home Offline - Loading from cache");

        final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

        if (cachedHome != null &&
            cachedHome.doc != null &&
            cachedHome.doc!.isNotEmpty) {
          print("Home Cache Found");

          emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
        } else {
          print("Home Cache Empty");

          showMessage(event.context, "تحقق من اتصال الإنترنت", true);

          emit(NoInternetHomeViewState());
        }
      }
    });
  }
}
