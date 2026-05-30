
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
   extendBody: true,
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

         Icon(
          Icons.favorite_border_rounded,
          size: 90,
          color: Theme.of(context).colorScheme.primary,
         )
             .animate(
          onPlay: (controller) =>
              controller.repeat(reverse: true),
         )
             .scale(
          begin: const Offset(1.2, 1.2),
          end: const Offset(1.1, 1.1),
          duration: 500.ms,
         ),

         const SizedBox(height: 15),

         Text(
          "لا توجد معاهد مفضلة",
          style: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.bold,
           color: Theme.of(context).colorScheme.primary,
          ),
         ).animate().fadeIn(duration: 1100.ms),
        ],
       ),
      )
          :Padding(
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
     padding: const EdgeInsets.only(left: 20),
     decoration: BoxDecoration(
     color: Theme.of(context).colorScheme.error,
     borderRadius: BorderRadius.circular(20),
     ),
     child: Icon(
     Icons.delete_rounded,
     size: 30,
     color: Theme.of(context).colorScheme.surface,
     ),
     ),

     child: TweenAnimationBuilder<double>(
     duration: Duration(milliseconds: 500 + (index * 120)),
     tween: Tween(begin: 0, end: 1),
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

     child: Material(
     color: Colors.transparent,
     child: InkWell(
     borderRadius: BorderRadius.circular(16),
     onTap: () {},

     child: Container(
     margin: const EdgeInsets.only(bottom: 14),
     padding: const EdgeInsets.all(14),
     decoration: BoxDecoration(
     color: Theme.of(context).colorScheme.surface,
     borderRadius: BorderRadius.circular(18),
     boxShadow: [
     BoxShadow(
     color: Theme.of(context)
         .colorScheme
         .primary
         .withOpacity(.15),
     blurRadius: 15,
     spreadRadius: 1,
     offset: const Offset(0, 8),
     ),
     ],
     ),

     child: Row(
     children: [
     Container(
     padding: const EdgeInsets.all(10),
     decoration: BoxDecoration(
     color: Theme.of(context)
         .colorScheme
         .primary
         .withOpacity(.12),
     borderRadius: BorderRadius.circular(12),
     ),
     child: Icon(
     Icons.school_rounded,
     color: Theme.of(context).colorScheme.primary,
     ),
     ),

     const SizedBox(width: 14),

     Expanded(
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
     Text(
     item['name']!,
     maxLines: 1,
     overflow: TextOverflow.ellipsis,
     style: const TextStyle(
     fontWeight: FontWeight.bold,
     fontSize: 16,
     ),
     ),

     const SizedBox(height: 4),

     Text(
     item['location'] ?? '',
     maxLines: 1,
     overflow: TextOverflow.ellipsis,
     style: TextStyle(
     color: Colors.grey.shade600,
     ),
     ),
     ],
     ),
     ),
      Icon(
     Icons.favorite,
     color: Theme.of(context).colorScheme.error,
     )
         .animate(
     onPlay: (controller) =>
     controller.repeat(reverse: true),
     )
         .scale(
     begin: const Offset(1.4, 1.4),
     end: const Offset(1, 1),
     duration: 900.ms,
     ),
     ],
     ),
     ),
     ),
     ),
     ),
     )
         .animate()
         .fadeIn(
     duration: 600.ms,
     delay: (index * 100).ms,
     )
         .slideY(
     begin: 0.3,
     end: 0,
     curve: Curves.easeOutQuart,
     );
     },
     ),
     )
     );


    },


   ):
   ProfilePage(),


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
}