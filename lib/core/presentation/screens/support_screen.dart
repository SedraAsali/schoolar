import 'package:flutter/material.dart';

import '../widgets/support_widget.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدعم"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             Text(
              "كيف يمكننا مساعدتك؟",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// WhatsApp
            buildSupportCard(
              context: context,
              icon: Icons.chat,
              title: "واتساب الدعم",
              subtitle: "تواصل معنا مباشرة لحل مشكلتك بسرعة",
              onTap: () {

              },
            ),

            const SizedBox(height: 12),

            /// Email
            buildSupportCard(
              context: context,
              icon: Icons.email,
              title: "البريد الإلكتروني",
              subtitle: "support@scholar-app.com",
              onTap: () {

              },
            ),

            const SizedBox(height: 12),

            /// FAQ
            buildSupportCard(
              context: context,
              icon: Icons.help_outline,
              title: "الأسئلة الشائعة",
              subtitle: "إجابات لأكثر الأسئلة تكراراً",
              onTap: () {},
            ),

            const SizedBox(height: 12),

            /// Report Bug
            buildSupportCard(
              context: context,
              icon: Icons.bug_report,
              title: "الإبلاغ عن مشكلة",
              subtitle: "أخبرنا عن أي خطأ في التطبيق",
              onTap: () {},

            ),

            const SizedBox(height: 30),

             Center(
              child: Text(
                "نرد عادة خلال 24 - 48 ساعة",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary,),
              ),
            ),
          ],
        ),
      ),
    );
  }}

