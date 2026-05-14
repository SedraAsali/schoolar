import 'package:flutter/material.dart';

import '../../domain/models/onboarding_data.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indecator.dart';
import 'logIn.dart';

class OnboardingScreen extends StatefulWidget {
const OnboardingScreen({super.key});

@override
State<OnboardingScreen> createState() =>
_OnboardingScreenState();
}

class _OnboardingScreenState
extends State<OnboardingScreen> {

final PageController _pageController =
PageController();

int currentPage = 0;

void nextPage() {
  //التقل بين شاشات الانبوردنغ
if (currentPage < onboardingItems.length - 1) {

_pageController.nextPage(
duration: const Duration(milliseconds: 300),
curve: Curves.easeInOut,
);

} else {

// الانتقال لصفحة تسجيل الدخول أو الهوم
  Navigator.push(context, MaterialPageRoute(builder:(context)=> LogIn()));

}
}

@override
Widget build(BuildContext context) {
  return Scaffold(


 body: SafeArea(
   child: Column(
         children: [

/// الصفحات
    Expanded(
      child: PageView.builder(
        controller: _pageController,

             onPageChanged: (index) {
             setState(() {
             currentPage = index;
});
},

     itemCount: onboardingItems.length,

       itemBuilder: (context, index) {
        return Column(
              children: [

/// الصفحة نفسه         ا
           Expanded(
               child: OnboardingPage(
                   item: onboardingItems[index],
),
),

          /// indicators
                   Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                      children: List.generate(
                        onboardingItems.length,
                        (indicatorIndex) =>
                 PageIndicator(
                   isActive:
                     currentPage == indicatorIndex,))),

           const SizedBox(height: 25),

/// زر التالي
                Padding(
                    padding:
                 const EdgeInsets.symmetric(
                    horizontal: 24,
                       ),
                       child: SizedBox(
                        width: double.infinity,
                         height: 58,
                       child: ElevatedButton(

                        onPressed: nextPage,

                       style:
                       ElevatedButton.styleFrom(
                        backgroundColor:Theme.of(context).colorScheme.primary,
                         shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
),
),

                           child: Text(
                              currentPage == onboardingItems.length - 1
                            ? "ابدأ الآن" : "التالي",

                                 style: const TextStyle(
                                 fontSize: 18,
                                  fontWeight: FontWeight.bold,),),))),

                                  SizedBox(height: 30),
],
);
},
),
),
],
),
),
);
}
}