import 'package:flutter/material.dart';
import 'package:scholar/core/feature_login/presentation/LogInView.dart';
import 'package:scholar/core/feature_on_boarding/data/on_boarding_data.dart';
import 'package:scholar/core/feature_on_boarding/widgets/on_boarding_page.dart';
import 'package:scholar/core/feature_on_boarding/widgets/page_indecator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  final PageController _pageController = PageController();
  int currentPage = 0;


  @override
  void initState() {
    triggeredUserShowedOnBoarding();
    super.initState();
  }

  triggeredUserShowedOnBoarding()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isShowedOnBoarding", true);
  }


  void nextPage() {
    //التنقل بين شاشات الانبوردنغ
    if (currentPage < onboardingItemsView.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // الانتقال لصفحة تسجيل الدخول أو الهوم
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogInView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: body(),
    );

  }

  Widget body()
  {
    return SafeArea(
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

              itemCount: onboardingItemsView.length,

              itemBuilder: (context, index) {
                return Column(
                  children: [
                    /// الصفحة نفسه         ا
                    Expanded(
                      child: OnboardingPageView(
                        item: onboardingItemsView[index],
                      ),
                    ),

                    /// indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingItemsView.length,
                            (indicatorIndex) => PageIndicator(
                          isActive: currentPage == indicatorIndex,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// زر التالي
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: nextPage,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: Text(
                            currentPage == onboardingItemsView.length - 1
                                ? "ابدأ الآن"
                                : "التالي",

                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
