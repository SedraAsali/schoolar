import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';

import '../../../helper/global_variable_provide.dart';
import '../../feature_favorites/presentation/add_favorite_bloc/add_favorite_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String academyId;
  final BuildContext context;

  const FavoriteButton({
    super.key,
    required this.academyId,
    required this.context,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    final favorites = await SharedPreferencesHelper.getFavorite();
    print("loadFavorite favorites $favorites");
    setState(() {
      isFav = favorites.any((e) => widget.academyId == e.academyId?.id);
      print("isFav $isFav");
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AddFavoriteBloc, AddFavoriteState>(
      listener: (context, state) {

        if (state is SuccessAddFavoriteState) {

          loadFavorite();

        }

      },
      child: IconButton(
        onPressed: () {

          final userId =
              Provider.of<GlobalVariableProvider>(
                context,
                listen: false,
              ).configClass?.userLogin?.user?.id;


          if(userId == null){
            return;
          }


          context.read<AddFavoriteBloc>().add(
            AddFavoriteViewEvent(
              context: context,
              academyId: widget.academyId,
              userId: userId,
            ),
          );

        },
        icon: Icon(
          isFav
              ? Icons.favorite
              : Icons.favorite_border,
          color: Theme.of(context)
              .colorScheme
              .error,
        ),
      ),
    );
  }
}
