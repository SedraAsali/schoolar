import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_home/data/home_view_api.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';

import '../../../../helper/global_variable_provide.dart';
import '../../../../helper/show_message.dart';
part 'home_view_event.dart';
part 'home_view_state.dart';
HomeViewModel filterAcademiesForUser(
    HomeViewModel homeViewModel,
    String? role,
    String? userId,
    ) {
  if (role == "MANAGER" && userId != null) {
    homeViewModel.doc = homeViewModel.doc
        ?.where(
          (academy) => academy.managerId?.id == userId,
    )
        .toList();
  }

  return homeViewModel;
}
class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(HomeViewInitial()) {
    print("bloc created");
    on<LoadingHomeViewEvent>((event, emit) async {
      print("event recived");
      final configClass = Provider.of<GlobalVariableProvider>(
        event.context,
        listen: false,
      ).configClass;

      final user = configClass?.userLogin?.user;

      final String? userId = user?.id;
      final String? role = user?.role;

      print("USER ID => $userId");
      print("USER ROLE => $role");

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

          // if (homeViewModel.status == "success") {
          //   print("HomeViewBloc GetAllDataHomeViewState");
          //   await SharedPreferencesHelper.saveHomeAcademies(homeViewModel);
          //   emit(GetAllDataHomeViewState(homeViewModel: homeViewModel));
          // }
          if (homeViewModel.status == "success") {

            await SharedPreferencesHelper.saveHomeAcademies(
              homeViewModel,
            );

            if (role == "MANAGER" && userId != null) {

              homeViewModel.doc = homeViewModel.doc
                  ?.where(
                    (academy) => academy.managerId?.id == userId,
              )
                  .toList();

              print("Manager academies => ${homeViewModel.doc}");
            }

            print("HomeViewBloc GetAllDataHomeViewState");

            emit(
              GetAllDataHomeViewState(
                homeViewModel: homeViewModel,
              ),
            );
          }
          else {
            print("HomeViewBloc ErrorHomeViewState");

            emit(ErrorHomeViewState());
          }
        } on SocketException {
          print("HomeViewBloc SocketException");

          final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

          if (cachedHome != null &&
              cachedHome.doc != null &&
              cachedHome.doc!.isNotEmpty)
          {
            final filteredHome = filterAcademiesForUser(cachedHome, role, userId,);
            print("Home Cache Found after SocketException");

           // emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
            emit(GetAllDataHomeViewState(homeViewModel: filteredHome));
          }
          else {
            emit(NoInternetHomeViewState());
          }
        } on TimeoutException {
          print("HomeViewBloc TimeoutException");

          final cachedHome = await SharedPreferencesHelper.getHomeAcademies();

          if (cachedHome != null &&
              cachedHome.doc != null &&
              cachedHome.doc!.isNotEmpty) {
            print("Home Cache Found after Timeout");
            final filteredHome = filterAcademiesForUser(cachedHome, role, userId,);
           // emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
            emit(GetAllDataHomeViewState(homeViewModel: filteredHome));
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
            final filteredHome = filterAcademiesForUser(cachedHome, role, userId,);
          //  emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
            emit(GetAllDataHomeViewState(homeViewModel: filteredHome));
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
          final filteredHome = filterAcademiesForUser(cachedHome, role, userId,);
         // emit(GetAllDataHomeViewState(homeViewModel: cachedHome));
          emit(GetAllDataHomeViewState(homeViewModel: filteredHome));
        } else {
          print("Home Cache Empty");

          showMessage(event.context, "تحقق من اتصال الإنترنت", true);

          emit(NoInternetHomeViewState());
        }
      }
    });
  }
}
