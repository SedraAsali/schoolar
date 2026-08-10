 import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart'as prov;
import 'package:scholar/core/feature_home/presentation/institute_details.dart';
import '../../../helper/constant.dart';
import '../../../helper/global_variable_provide.dart';
import '../../feature_favorites/provider/favorites_provider.dart';
import '../data/home_view_model.dart';
import 'favorite_button.dart';

Widget instituteCard({
required BuildContext context,
required WidgetRef ref,
required Doc academy,
required String academyId,
required String name,
required String location,
required int rating,
required String image,
 required int index,
}) {
 final favorites = ref.watch(favoritesProvider);
 final isFav = favorites.any((e) => e['name'] == name);
 final role =prov. Provider.of<GlobalVariableProvider>(
  context,
  listen: false,
 ).configClass?.userLogin?.user?.role;
 print("role fav btn $role");
 return InkWell(
  onTap: () {
   Navigator.push(
    context,
    MaterialPageRoute(
     builder: (context) => InstituteDetailsScreen(academy: academy,),
    ),
   );
  },
  child: TweenAnimationBuilder(
   duration:
   Duration(milliseconds: 500 ),
   tween: Tween(begin: 0.0, end: 1.0),
   curve: Curves.easeOutCubic,
   builder: (context, value, child) {
    return Opacity(
     opacity: value,
     child: Transform.translate(
      offset: Offset(0, 50 * (1 - value)),
      child: child,
     ),
    );
   },
   child:

   Container(
    margin: const EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
     color: Theme.of(context).colorScheme.onInverseSurface,
     borderRadius: BorderRadius.circular(24),
     boxShadow: [
      BoxShadow(
       color: Theme.of(context).colorScheme.primary,
       blurRadius: 3,
       offset: const Offset(0, 2),
      )
     ],
    ),
    child: Row(
     children: [

      /// IMAGE
      ClipRRect(
          borderRadius: const BorderRadius.horizontal(
           right: Radius.circular(24),
          ),
          child:

          Image.network(
           width: 120,
           height: 120,
           image,
           fit: BoxFit.cover,
           errorBuilder: (_, _, _) {
            return Container(
             color: Theme
                 .of(context)
                 .colorScheme
                 .outlineVariant,
             child: Center(
              child:SvgPicture.asset('lib/svgFiles/school.svg',
                  height: 120,
                  semanticsLabel: 'school')
              // Icon(Icons.broken_image, size: 120,
              //  color: Theme
              //      .of(context)
              //      .colorScheme
              //      .onInverseSurface,
              // ),
             ),
            );
           },
          )
      ),
      SizedBox(width: 5,),
      Expanded(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

         /// NAME + FAVORITE BUTTON
         Row(
          children: [
           Expanded(
            child: Text(
             name,
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
             ),
            ),
           ),

          role!="MANAGER"? FavoriteButton(
            academyId: academyId,
            context: context,
           ):Container(),

          ],
         ),

         const SizedBox(height: 5),

         Row(
          children: [
           Icon(
            Icons.location_on,
            size: 18,
            color: Theme
                .of(context)
                .colorScheme
                .outlineVariant,
           ),
           const SizedBox(width: 6),
           Expanded(
            child: Text(
             location,
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
              color: Theme
                  .of(context)
                  .colorScheme
                  .outlineVariant,
             ),
            ),
           ),
          ],
         ),

         const SizedBox(height: 10),

         Row(
          children: [
           Icon(
            Icons.star,
            color: gold,
            size: 20,
           ),
           const SizedBox(width: 5),
           Text(
           "$rating",
            style: const TextStyle(
             fontWeight: FontWeight.bold,
            ),
           ),
          ],
         ),
        ],
       ),
      ),
     ],
    ),
   ),

  )).animate()
     .fadeIn(
  duration: 700.ms,
  delay: (index * 120).ms,
 )
     .slideY(
  begin: 0.5,
  end: 0,
  curve: Curves.easeOutCubic,


 );
}

