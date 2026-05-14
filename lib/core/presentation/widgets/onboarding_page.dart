import 'package:flutter/material.dart';
import '../../domain/models/onboarding_model.dart';
import '../screens/logIn.dart';

//شاشة onboarding وحدة وحدة
class OnboardingPage extends StatelessWidget {
  final OnboardingModel item;

  const OnboardingPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          /// Top Skip
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn(),));

              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),


          const SizedBox(height: 40),

          /// IMAGE
          Expanded(
            flex: 20,
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(30),
              child: Image.asset(

                item.image,
              
              
                        ),
            ),
          ),
           SizedBox(height: 20),

          /// TITLE
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          /// DESCRIPTION
          Text(
            item.description,
            textAlign: TextAlign.center,
            style:  TextStyle(
              height: 1.6,
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          const Spacer(),

        ],
      ),
    );
  }
}