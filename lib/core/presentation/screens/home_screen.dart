
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/presentation/screens/profile.dart';
import '../../constant.dart';
import '../providers/favorites_provider.dart';
import '../providers/home_navication.dart';
import '../widgets/card.dart';
import 'global_form.dart';


class HomeScreen extends ConsumerWidget {
 const HomeScreen({super.key});


 @override
 Widget build(BuildContext context,ref) {
  var currentIndex= ref.watch(homeNavigationProvider);
  return Scaffold(

  /* appBar: AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(90)),
    ),
   ),*/
   body:
   currentIndex==0?
   SafeArea(
    child: SingleChildScrollView(
     padding: const EdgeInsets.all(18),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

       //const SizedBox(height: 24),

       /// SEARCH BAR
       Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),
         boxShadow: [
          BoxShadow(
           color: Theme.of(context).colorScheme.primary,
           blurRadius: 5,
           offset: const Offset(2, 3),
          ),
         ],
        ),
        child: ReactiveForm(
          formGroup: globalFormGroup,
          child: Column(
            children: [
              ReactiveTextField<String>(
               formControlName: 'search',
               decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: "ابحث عن معهد أو منطقة...",
               ),
              ),
            ],
          ),
        ),
       ),
       const SizedBox(height: 25),

       /// TOP BANNER
       Container(
        height: 210,
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(27),
         gradient: LinearGradient(
          colors: [
           darkBlue,
           const Color(0xFF163B68),
           const Color(0xFF163B68),
           darkBlue,
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
            backgroundColor: gold.withOpacity(0.1),
           ),
          ),
          Positioned(
           right: -20,
           top: -6,
           child: CircleAvatar(
            radius: 80,
            backgroundColor: gold.withOpacity(0.18),
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
                color: Colors.black,
               ),
              ),
             ),

             const SizedBox(height: 18),

             const Text(
              "اكتشف أفضل المعاهد\nفي منطقتك",
              maxLines:2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
               fontSize: 28,
               color: Colors.white,
               fontWeight: FontWeight.bold,
               height: 1.4,
              ),
             ),

             const SizedBox(height: 10),

             const Text(
              "تعليم أكاديمي احترافي بأفضل التقييمات",
              maxLines:1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
               color: Colors.white70,
               fontSize: 15,
              ),
             ),
            ],
           ),
          ),
         ],
        ),
       ),
       const SizedBox(height: 20),

       /// SECTION TITLE
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Text(
          "المعاهد من الأكثر تقيماً",
          style: TextStyle(
           color: Theme.of(context).colorScheme.primary,
           fontSize: 22,
           fontWeight: FontWeight.bold,
          ),
         ),
         InkWell(
          onTap: (){

          },
           child: Text(
            "عرض الكل",
            style: TextStyle(
             color: gold,
             fontWeight: FontWeight.bold,
            ),
           ),
         ),
        ],
       ),
       const SizedBox(height: 20),

       instituteCard(
        ref: ref,
        name: "معهد النخبة",
        location: "السبيل-قرب جامع الرحمن",
        rating: "4.0",
        image:
        "https://tse4.mm.bing.net/th/id/OIP.bTUquEP24f1MhL_EMSq0RgHaHf?rs=1&pid=ImgDetMain&o=7&rm=3",
        context: context,
       ),

       instituteCard(
           context: context,
        name: "أكاديمية رويال",
        location: "الفرقان-أمام باب الاقتصاد",
        rating: "2.3",
        image:
            "https://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
           ref: ref

       ),

       const SizedBox(height: 30),
      ],
     ),
    ),
   ):


   currentIndex == 1
       ? Consumer(
    builder: (context, ref, _) {
     final favorites = ref.watch(favoritesProvider);

     return SafeArea(
      child: favorites.isEmpty
          ?  Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Icon(Icons.favorite_border,
             size: 80,
          color: Theme.of(context).colorScheme.primary,
     ),
         SizedBox(height: 10),
         Text("لا توجد معاهد مفضلة",
         style: TextStyle(
          fontSize: 19,
          color:  Theme.of(context).colorScheme.primary
         ),),
        ],
       ),
      )
          : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                   padding: const EdgeInsets.all(12),
                   itemCount: favorites.length,
                   itemBuilder: (context, index) {
                    final item = favorites[index];

                    return Dismissible(
                     key: Key(item['name']!),
                     direction: DismissDirection.endToStart,
                     onDismissed: (_) {
            ref
                .read(favoritesProvider.notifier)
                .remove(item['name']!);
                     },
                     background: Container(
            alignment: Alignment.centerLeft,
            padding:  EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.error,
             borderRadius: BorderRadius.circular(20),
            ),
            child:  Icon(Icons.delete,
                color: Theme.of(context).colorScheme.surface),
                     ),
                     child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(16),
             boxShadow: [
              BoxShadow(
               color: Theme.of(context).colorScheme.primary,
               blurRadius: 4,
               offset: const Offset(0, 3),
              )
             ],
            ),
            child: Row(
             children: [
               Icon(Icons.school,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),

              Expanded(
               child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                 Text(
                  item['name']!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                 ),
                 Text(
                     overflow: TextOverflow.ellipsis,
                     maxLines: 1,
                     item['location'] ?? ''),
                ],
               ),
              ),

               Icon(Icons.favorite,
                  color:Theme.of(context).colorScheme.error,),
             ],
            ),
                     ),
                    );
                   },
                  ),
          ),
     );
    },


   ):
   ProfilePage(),


   bottomNavigationBar:

   BottomNavigationBar(
    elevation: 0,
    type: BottomNavigationBarType.shifting,
    selectedItemColor: gold,
    currentIndex:currentIndex,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    onTap: (value)
    {ref.read(homeNavigationProvider.notifier).state=value;
    },
    items: [
     BottomNavigationBarItem(
         icon: Icon(Icons.home,),
         label: 'الرئيسية'),

     BottomNavigationBarItem(icon: Icon(Icons.favorite),
         label: 'المفضلة'),

     BottomNavigationBarItem(icon: Icon(Icons.person),
         label: 'الحساب'),
    ], ),
  );
 }
}