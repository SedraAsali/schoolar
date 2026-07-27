import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scholar/core/feature_home/data/home_view_api.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
part 'home_view_event.dart';
part 'home_view_state.dart';


class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {

  HomeViewBloc() : super(HomeViewInitial()) {
   print("bloc created");
    on<LoadingHomeViewEvent>((event, emit) async {
      print("event recived");
      emit(LoadingHomeViewState());

      try {
        HomeViewModel homeViewModel =
        await HomeViewApi.getAllAcademies(event.context);

        print("HomeViewBloc homeViewModel ${homeViewModel.status}");

        if (homeViewModel.status == "success") {

          print("HomeViewBloc GetAllDataHomeViewState");

          emit(
            GetAllDataHomeViewState(
              homeViewModel: homeViewModel,
            ),
          );

        } else {

          print("HomeViewBloc ErrorHomeViewState");

          emit(ErrorHomeViewState());

        }

      } catch (e) {

        print("HomeViewBloc catch ErrorHomeViewState");

        emit(ErrorHomeViewState());

      }

    });

  }
}

// class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState>  {
//   HomeViewBloc() : super(HomeViewInitial());
//
//   @override
//   Stream<HomeViewState> mapEventToState(HomeViewEvent event) async* {
//     if (event is LoadingHomeViewEvent) {
//       yield LoadingHomeViewState();
//       HomeViewModel homeViewModel = await HomeViewApi.getAllAcademies();
//       print("HomeViewBloc homeViewModel ${homeViewModel.status}");
//       try {
//         if (homeViewModel.status == "success") {
//           print("HomeViewBloc  GetAllDataHomeViewState");
//           yield GetAllDataHomeViewState(homeViewModel: homeViewModel);
//         } else {
//           print("HomeViewBloc  ErrorHomeViewState");
//           yield ErrorHomeViewState();
//         }
//       } catch (e) {
//         print("HomeViewBloc catch ErrorHomeViewState");
//         yield ErrorHomeViewState();
//       }
//     }
//     // if(event is FetchFilterEvent)
//     // {
//     //
//     //   var connectivityResult = await (Connectivity().checkConnectivity());
//     //
//     //   if (connectivityResult == ConnectivityResult.wifi ||
//     //       connectivityResult == ConnectivityResult.mobile)
//     //   {
//     //     yield LoadingHomeViewState();
//     //
//     //     FilterFoodApi filterFoodApi = FilterFoodApi();
//     //
//     //     FilterModel filterModel = await filterFoodApi.getFilter(event.context,event.idsCategory, event.minPrice, event.maxPrice);
//     //     if(filterModel.status == "OK")
//     //       yield SuccessFilterState(filterModel);
//     //     else
//     //       yield ErrorHomeViewState();
//     //   }
//     //   else
//     //     {
//     //       showMessage(getTextLanguage(event.context.locale, "check internet connection", "Überprüfen Sie die Internetverbindung", "internet bağlantısını kontrol et", "تحقق من اتصال الإنترنت"), true);
//     //       yield ErrorHomeViewState();
//     //     }
//     //
//     // }
//   }
// }
