
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
import 'favorite_screen.dart';
import 'global_form.dart';


class HomeScreen extends ConsumerWidget {
 const HomeScreen({super.key});


 @override
 Widget build(BuildContext context,ref) {
  var currentIndex= ref.watch(homeNavigationProvider);
  //لائحة المعاهد من اجل عملية فلترة البحث
  final institutes = [
   {
    "name": "معهد النخبة",
    "location": "السبيل-قرب جامع الرحمن",
    "rating": "4.0",
    "image":
    "h ttps://tse4.mm.bing.net/th/id/OIP.bTUquEP24f1MhL_EMSq0RgHaHf?rs=1&pid=ImgDetMain&o=7&rm=3",
   },
   {
    "name": "أكاديمية رويال",
    "location": "الفرقان-أمام باب الاقتصاد",
    "rating": "2.3",
    "image":
    "https://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
   },
  {
    "name": " معهد التفوق",
    "location": "حلب الجديدة",
    "rating": "4.3",
    "image":
    "h ttps://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
   },
   {
    "name": "معهد المتنبي",
    "location": "الحمدانية_لحي 3",
    "rating": "1.3",
    "image":
    "h ttps://th.bing.com/th/id/OIP.-7TM23FZ8KhK8h3V3rq8gAHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3",
   },
  ];
  return Scaffold(
   extendBody: true,
   body:
   currentIndex==0?

   SafeArea(
    child: SingleChildScrollView(
     padding: const EdgeInsets.all(18),
     child: ReactiveForm(
      formGroup: globalFormGroup,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

        Container(
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
         child:


         ReactiveTextField<String>(
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
        ),

        const SizedBox(height: 25),

        /// TOP BANNER

    Container(
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
               color:  Theme.of(context).colorScheme.surface.withOpacity(0.6),
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

        ReactiveValueListenableBuilder<String>(
         formControlName: 'search',
         builder: (context, control, child) {
          final search =
          (control.value ?? '')
              .trim()
              .toLowerCase();

          final filteredInstitutes =
          institutes.where((item) {
           final name =
           item['name']!.toLowerCase();

           final location =
           item['location']!.toLowerCase();

           return search.isEmpty ||
               name.contains(search) ||
               location.contains(search);
          }).toList();

          if (filteredInstitutes.isEmpty) {
           return Padding(
            padding: const EdgeInsets.symmetric(
             vertical: 100,
            ),
            child: Center(
             child: Text(
              "لا توجد نتائج مطابقة ل ' $search ' ",
              style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
               color: Theme.of(context)
                   .colorScheme
                   .primary,
              ),
             ),
            ),
           );
          }

          return Column(
           children: filteredInstitutes.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return instituteCard(
             ref: ref,
             context: context,
             name: item['name']!,
             location: item['location']!,
             rating: item['rating']!,
             image: item['image']!,
             index: index,
            );
           }).toList(),
          );
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
   FavoritesPage()
       :
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