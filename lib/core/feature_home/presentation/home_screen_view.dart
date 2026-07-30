
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_favorites/presentation/favorite_screen.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/core/feature_home/presentation/academies_bloc/home_view_bloc.dart';
import 'package:scholar/core/feature_home/widget/card.dart';
import 'package:scholar/helper/widgets/loading_view.dart' show LoadingView;
import 'package:scholar/helper/widgets/state_view.dart' show StateView;
import '../../../helper/constant.dart';
import '../../feature_favorites/presentation/favorites_bloc/favorites_view_bloc.dart';
import '../../feature_user_profile/presentation/profile_view.dart';
import '../provider/home_navication.dart';
import '../provider/showInistut_provider.dart';
import 'global_form.dart';

class HomeScreenView extends ConsumerStatefulWidget {
  const HomeScreenView({super.key});

  @override
  ConsumerState<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends ConsumerState<HomeScreenView> {

 @override
 void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
   context.read<HomeViewBloc>().add(
    LoadingHomeViewEvent(context: context),
   );
  });
 // BlocProvider.of<HomeViewBloc>(context).add(LoadingHomeViewEvent());

 // tabBarListViewProvide = Provider.of<TabBarListViewProvide>(context, listen: false);
 // tabBarListViewProvide.initValues();

 }
 @override
 Widget build(BuildContext context) {
  var currentIndex= ref.watch(homeNavigationProvider);
  final   showAll=ref.watch(showAllProvider);
  //لائحة المعاهد من اجل عملية فلترة البحث
  // final institutes = [
  //  {
  //   "name": "معهد النخبة",
  //   "location": "السبيل-قرب جامع الرحمن",
  //   "rating": "4.0",
  //   "image":
  //   "h ttps://tse4.mm.bing.net/th/id/OIP.bTUquEP24f1MhL_EMSq0RgHaHf?rs=1&pid=ImgDetMain&o=7&rm=3",
  //  },
  //  {
  //   "name": "أكاديمية رويال",
  //   "location": "الفرقان-أمام باب الاقتصاد",
  //   "rating": "2.3",
  //   "image":
  //   "https://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
  //  },
  //  {
  //   "name": " معهد التفوق",
  //   "location": "حلب الجديدة",
  //   "rating": "4.3",
  //   "image":
  //   "h ttps://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
  //  },
  //  {
  //   "name": "معهد المتنبي",
  //   "location": "الحمدانية_لحي 3",
  //   "rating": "1.3",
  //   "image":
  //   "h ttps://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
  //  },
  // ];
  return Scaffold(
   extendBody: true,
   body: currentIndex==0?

   SafeArea(
    child: SingleChildScrollView(
     padding: const EdgeInsets.all(18),
     child: ReactiveForm(
      formGroup: globalFormGroup,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

        search(),

        const SizedBox(height: 25),
         cardPopularAcademy(),
        const SizedBox(height: 20),

        //فلترة النصحسب البحث
        BlocBuilder<HomeViewBloc, HomeViewState>(
         builder: (context, state) {
          if (state is LoadingHomeViewState) {
            return Center(child: LoadingView());
          }
          else if (state is ErrorHomeViewState)
           {
            return StateView(
             // imagePath:'lib/svgFiles/no_internet_connection.svg' ,
             imagePath:'lib/svgFiles/something_wrong.svg' ,
             imageHeader: 'حدث خطأ ما رجاءا إعادة المحاولة',
             iconRefresh: true,
             //imageDescription: 'no_wifi_description',
             function: () {
              // BlocProvider.of<HomeViewBloc>(context)
              //  .add(LoadingHomeViewEvent());
              context.read<HomeViewBloc>().add(
               LoadingHomeViewEvent(context: context),
              );

             },
            );
           }
          else if (state is NoInternetHomeViewState)
          {
           return StateView(
             imagePath:'lib/svgFiles/no_internet_connection.svg' ,
            function: () {
             // BlocProvider.of<HomeViewBloc>(context)
             //  .add(LoadingHomeViewEvent());
             context.read<HomeViewBloc>().add(
              LoadingHomeViewEvent(context: context),
             );

            },
           );
          }
          else if (state is GetAllDataHomeViewState)
           {
            print("state.homeViewModel.doc ${state.homeViewModel.doc}");
            List<Doc> academies = List.from(state.homeViewModel.doc ?? []);
            if(academies.isEmpty)
             {
              return StateView(
               imagePath: 'lib/svgFiles/no_classes.svg',
                imageHeader: 'لا يوجد معاهد',
               // imageDescription: 'no_meal_description',
              );
             }
            else
             {
              return academyListCards(academies, showAll);
             }
           }
          return Center(child: LoadingView());
  },
),
       ],
      ),
     ),
    ),
   )
       :
   currentIndex == 1
       ?
   BlocProvider(
    create: (context) => FavoritesViewBloc(),
    child: const FavoritesPage(),
   )
       :
   ProfilePageView(),


   bottomNavigationBar: CurvedNavigationBar(

    backgroundColor: Colors.transparent,

    color:   Theme.of(context).colorScheme.onInverseSurface,

    buttonBackgroundColor: gold,

    height: 60,

    animationDuration: const Duration(milliseconds: 400),

    index: currentIndex,

    items: [

     Icon(
      size: 30,
      Icons.home_filled,
      color: currentIndex == 0
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.outlineVariant,
     ),

     Icon(
      size: 30,
      Icons.favorite,
      color: currentIndex == 1
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.outlineVariant,
     ),

     Icon(
      Icons.person,
      size: 30,
      color: currentIndex == 2
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.outlineVariant,
     ),
    ],

    onTap: (index) {

     ref.read(homeNavigationProvider.notifier).state = index;

    },
   ),

  );
 }



 Widget search() {
  return Container(
   padding: const EdgeInsets.symmetric(horizontal: 16),
   decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.onInverseSurface,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
     BoxShadow(
      color: Theme.of(context).colorScheme.primary,
      blurRadius: 3,
      offset: const Offset(0 ,2),
     ),
    ],
   ),
   child: ReactiveTextField<String>(
    style: TextStyle(
     color: Theme.of(context).colorScheme.outline,
    ),
    formControlName: 'search',
    decoration: InputDecoration(
     hintText: "أدخل اسم المنطقة أو المعهد..",
     fillColor:   Theme.of(context).colorScheme.onInverseSurface,
     border: InputBorder.none,
     prefixIcon:  Icon(Icons.search,color: Theme.of(context).colorScheme.secondary,),
     suffixIcon: globalFormGroup.control('search').value.toString().isNotEmpty
         ? IconButton(
      icon:  Icon(Icons.close,
       color: Theme.of(context).colorScheme.secondary ,),
      onPressed: () {
       globalFormGroup.control('search').value = '';
      },
     )
         : null,
    ),
   ),
  );
 }

 Widget cardPopularAcademy() {
  return  Container(
   height: 210,
   decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(27),
    gradient: LinearGradient(
     colors: [
      Theme.of(context).colorScheme.inverseSurface,
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.inverseSurface,
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.inverseSurface,
     ],
     begin: Alignment.topLeft,
     end: Alignment.bottomRight,
    ),
   ),
   child: Stack(
    children: [
     Positioned(
      left: -3,
      bottom: -5,
      child: CircleAvatar(
       radius: 40,
       backgroundColor: gold.withValues(alpha: 0.1),
      ),
     ),
     Positioned(
      right: -20,
      top: -6,
      child: CircleAvatar(
       radius: 80,
       backgroundColor: gold.withValues(alpha: 0.18),
      ),
     ),
     Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.center,
       children: [

        Container(
         padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
         ),
         decoration: BoxDecoration(
          color: gold,
          borderRadius: BorderRadius.circular(20),
         ),
         child: const Text(
          "معاهد مشهورة",
          maxLines:1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
           fontWeight: FontWeight.bold,
          ),
         ),
        ),

        const SizedBox(height: 18),

        Text(
         "اكتشف أفضل المعاهد\nفي منطقتك",
         maxLines:2,
         overflow: TextOverflow.ellipsis,
         style: TextStyle(

          fontSize: 28,
          color:  Theme.of(context).colorScheme.surface,

          fontWeight: FontWeight.bold,
          height: 1.4,
         ),
        ),

        const SizedBox(height: 10),

        Text(
         "تعليم أكاديمي احترافي بأفضل التقييمات",
         maxLines:1,
         overflow: TextOverflow.ellipsis,
         style: TextStyle(
          color:  Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
          fontSize: 15,
         ),
        ),
       ],
      ),
     ),
    ],
   ),
  );
 }

 Widget academyListCards(List<Doc> academies, bool showAll) {
  return ReactiveValueListenableBuilder<String>(
   formControlName: 'search',
   builder: (context, control, child) {
    final search =
    (control.value ?? '')
        .trim()
        .toLowerCase();

    final hasSearch = search.isNotEmpty;

    final filteredInstitutes = hasSearch
        ? academies.where((academy) {
     final name = (academy.name??"").toLowerCase();
     final location = (academy.location??"").toLowerCase();

     return name.contains(search) ||
         location.contains(search);
    }).toList()
        : showAll
        ? academies
        : [...academies]
     ..sort(
          (a, b) => double.parse(
       "0",
      ).compareTo(
       double.parse(
        "0",
       ),
      ),
     );

    return Column(
     children: [
      Row(
       mainAxisAlignment:
       MainAxisAlignment.spaceBetween,
       children: [
        Text(
         hasSearch
             ? "نتائج البحث"
             : showAll
             ? "كل المعاهد"
             : "المعاهد الأكثر تقييماً",
         style: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
         ),
        ),
        if (!hasSearch)
         InkWell(
          onTap: () {
           ref
               .read(
            showAllProvider.notifier,
           )
               .state = !showAll;
          },
          child: Text(
           showAll
               ? "إخفاء"
               : "عرض الكل",
           style: TextStyle(
            color: gold,
            fontWeight:
            FontWeight.bold,
           ),
          ),
         ),
       ],
      ),

      const SizedBox(height: 20),

      if (filteredInstitutes.isEmpty)
       Padding(
        padding:
        const EdgeInsets.symmetric(
         vertical: 10,
        ),
        child: SvgPicture.asset('lib/svgFiles/no_search_results.svg',

            semanticsLabel: 'school'),
       )
      else
       Column(
        children:
        filteredInstitutes
            .asMap()
            .entries
            .map((entry) {
         final index = entry.key;
         final academy = entry.value;

         return instituteCard(
          ref: ref,
          context: context,
          name: academy.name??"",
          location:academy.location??"",
          rating: "0",
          image: "${academy.photo}"??"",
          index: index,
         );
        }).toList(),
       ),
     ],
    );
   },
  );
 }
}


