import 'package:flutter/material.dart';
import '../widgets/contain.dart';
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
              child: Column(
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 85),

                  buildButton(
                    icon: Icons.dark_mode,
                    color: Theme.of(context).colorScheme.primary,
                    text: "Change Theme",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ThemeDialogWidget(),
                      );
                    },
                  ),

                  SizedBox(height: 20),

                  buildButton(
                    icon: Icons.logout,
                    text: "Logout",
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {},
                  ),
                ],
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