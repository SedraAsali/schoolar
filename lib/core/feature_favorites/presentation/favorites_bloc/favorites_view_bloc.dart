import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity, ConnectivityResult;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';
import '../../data/GetFavoriteApi.dart';
import '../../data/GetFavoriteModel.dart';
part 'favorites_view_event.dart';
part 'favorites_view_state.dart';

class FavoritesViewBloc extends Bloc<FavoritesViewEvent, FavoritesViewState> {
  FavoritesViewBloc() : super(FavoritesViewInitial()) {
    on<LoadingFavoritesViewEvent>((event, emit) async {
      print("event received Favorites");

      emit(LoadingFavoritesViewState());

      var connectivityResult = await Connectivity().checkConnectivity();

      // يوجد إنترنت
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet)) {
        try {
          GetFavoriteModel getFavoriteModel = await FavoriteApi.getFavoriteApi(
            event.context,
            event.userID,
          );

          print("Favorites status ${getFavoriteModel.status}");

          if (getFavoriteModel.status == "success") {
            emit(GetAllFavoritesViewState(getFavoriteModel: getFavoriteModel));
          } else {
            emit(
              ErrorFavoritesViewState(
                message: getFavoriteModel.message ?? "Error",
              ),
            );
          }
        } on SocketException {
          // في حال انقطع النت أثناء الطلب
          await _getFavoriteFromCache(emit);
        } on TimeoutException {
          await _getFavoriteFromCache(emit);
        } catch (e) {
          print("Favorites Error $e");

          emit(ErrorFavoritesViewState(message: e.toString()));
        }
      }
      // لا يوجد إنترنت
      else {
        print("No Internet -> Load Cache");

        await _getFavoriteFromCache(emit);
      }
    });
  }

  Future<void> _getFavoriteFromCache(Emitter<FavoritesViewState> emit) async {
    List<Favorite> cached = await SharedPreferencesHelper.getFavorite();

    if (cached.isNotEmpty) {
      emit(
        GetAllFavoritesViewState(
          getFavoriteModel: GetFavoriteModel(status: "cache", data: cached),
        ),
      );
    } else {
      emit(NoInternetFavoritesViewState());
    }
  }
}

// class FavoritesViewBloc extends Bloc<FavoritesViewEvent, FavoritesViewState> {
//
//   FavoritesViewBloc() : super(FavoritesViewInitial()) {
//    print("bloc created Favorites");
//     on<LoadingFavoritesViewEvent>((event, emit) async {
//       print("event recived Favorites");
//       var connectivityResult = await Connectivity().checkConnectivity();
//
//       if (connectivityResult.contains(ConnectivityResult.mobile) ||
//           connectivityResult.contains(ConnectivityResult.wifi) ||
//           connectivityResult.contains(ConnectivityResult.ethernet))
//         {
//
//
//           emit(LoadingFavoritesViewState());
//
//           try {
//             GetFavoriteModel getFavoriteModel =
//             await FavoriteApi.getFavoriteApi(event.context,event.userID);
//
//             print("FavoritesViewBloc getFavoriteModel.status ${getFavoriteModel.status}");
//
//             if (getFavoriteModel.status == "success") {
//
//               print("FavoritesViewBloc GetAllFavoritesViewState");
//
//               emit(
//                 GetAllFavoritesViewState(
//                   getFavoriteModel:
//                 ),
//               );
//
//             } else {
//
//               print("FavoritesViewBloc ErrorFavoritesViewState");
//
//               emit(ErrorFavoritesViewState(message: ));
//
//             }
//
//           }
//           on SocketException {
//             print("FavoritesViewBloc SocketException NoInternetFavoritesViewState");
//
//             emit(NoInternetFavoritesViewState());
//           } on TimeoutException {
//             print("FavoritesViewBloc TimeoutException NoInternetFavoritesViewState");
//
//             emit(NoInternetFavoritesViewState());
//           } catch (e) {
//             print("FavoritesViewBloc catch ErrorFavoritesViewState $e ");
//             emit(ErrorFavoritesViewState(message: ));
//           }
//         }
//       else
//         {
//           showMessage(event.context,"تحقق من اتصال الإنترنت", true);
//           emit(NoInternetFavoritesViewState());
//         }
//
//     });
//
//   }
// }
