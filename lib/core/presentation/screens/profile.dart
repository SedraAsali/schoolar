import 'package:flutter/material.dart';
import 'package:scholar/core/presentation/screens/support_screen.dart';
import '../widgets/contain.dart';
import '../widgets/prof_info_card.dart';
import '../widgets/theme_dialog.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [

          // الكونتينر
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 90,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(150),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "اسم المستخدم",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    const SizedBox(height: 10),
                
                    Text(
                      "ScholarAppUser@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                
                    SizedBox(height: 35),
                
                    /// احصائيات بسيطة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        buildInfoCard("12", "المفضلة",context
                        ),
                        buildInfoCard("5", "تمت زيارتها",context),
                      ],
                    ),
                
                    SizedBox(height: 35),
                
                    buildButton(
                      context: context,
                      icon: Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                      text: "تعديل الحساب",
                      onTap: () {
                
                      },
                    ),

                    SizedBox(height: 20),
                
                    buildButton(
                      context: context,
                      icon: Icons.dark_mode,
                      color: Theme.of(context).colorScheme.primary,
                      text: "تغيير السمة",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ThemeDialogWidget(),
                        );
                      },
                    ),
                
                    SizedBox(height: 20),
                
                    buildButton(
                      context: context,
                      icon: Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                      text: "حول التطبيق",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:  Text("حول التطبيق",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary
                              ),
                              ),
                              content:  Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("📱 Scholar Institutes",
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  SizedBox(height: 8),
                                  Text("الإصدار: 1.0.0",
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  SizedBox(height: 8),
                                  Text(
                                    "تطبيق يساعد الطلاب في العثور على أفضل المعاهد التعليمية بسهولة.",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text("🏫 المميزات:",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  Text("- عرض المعاهد",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  Text("- المفضلة",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  Text("- التقييم",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                  SizedBox(height: 12),
                                  Text("© 2026 جميع الحقوق محفوظة",

                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                    ),),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("إغلاق"),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                
                    SizedBox(height: 20),
                
                    buildButton(
                      context: context,
                      icon: Icons.support_agent,
                      color: Theme.of(context).colorScheme.primary,
                      text: "دعم",
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SupportPage(),
                            ),
                          );
                      },
                    ),
                
                    SizedBox(height: 20),
                
                    buildButton(
                      context: context,
                      icon: Icons.logout,
                      text: "تسجيل خروج",
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                    ),
                    SizedBox(height: 5),


                    Text(
                      "الإصدار 1.0.0",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

            ),

          ),

          // الصورة
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    width: 140,
                    'assets/images/profilee.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
