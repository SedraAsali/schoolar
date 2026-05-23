import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scholar/core/presentation/screens/reportBug_screen.dart';

import '../widgets/support_widget.dart';
import 'fag_screen.dart';

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
            buildSupportCard(
              context: context,
              icon: Icons.chat,
              title: "رقم الدعم",
              subtitle: "تواصل معنا مباشرة لحل مشكلتك بسرعة",
              onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "رقم الدعم",
                              style: TextStyle(
                                color:  Theme.of(context).colorScheme.onSurface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),

                             Text(
                              "تواصل معنا مباشرة عبر الرقم وسنرد عليك بسرعة.",
                              style: TextStyle(color:  Theme.of(context).colorScheme.outlineVariant,),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child:  Row(
                                children: [
                                  Icon(Icons.phone, color: Colors.green),
                                  SizedBox(width: 10),
                                  Text(
                                    "0950062418",
                                    style: TextStyle(
                                      color:  Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon:  Icon(Icons.copy,
                                    color:  Theme.of(context).colorScheme.onSurface,),
                                    onPressed: (){
                                      const phone = "0950062418";

                                      Clipboard.setData(const ClipboardData(text: phone));

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("تم نسخ رقم الدعم"),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  )
                                ],
                              ),
                            ),],
                        ),
                      );

                });
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
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    const email = "support@scholar-app.com";

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                           Text(
                            "البريد الإلكتروني للدعم",
                            style: TextStyle(
                              color:  Theme.of(context).colorScheme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                           Text(
                            "يمكنك التواصل معنا عبر البريد وسيتم الرد خلال 24 - 48 ساعة.",
                            style: TextStyle(color: Theme.of(context).colorScheme.outlineVariant,),
                          ),

                          const SizedBox(height: 20),

                          Container(
                            padding:  EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:  Row(
                              children: [
                                Icon(Icons.email, color: Theme.of(context).colorScheme.primary,),
                                SizedBox(width: 10),
                                Text(
                                  email,

                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color:  Theme.of(context).colorScheme.onSurface,),
                                ),
                                Spacer(),
                                IconButton(
                                  icon:  Icon(Icons.copy,
                                  color:  Theme.of(context).colorScheme.onSurface,),
                                    onPressed: (){
                                      const email = "support@schoolar-app.com";

                                      Clipboard.setData(const ClipboardData(text: email));

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("تم نسخ الإيميل"),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            /// FAQ
            buildSupportCard(
              context: context,
              icon: Icons.help_outline,
              title: "الأسئلة الشائعة",
              subtitle: "إجابات لأكثر الأسئلة تكراراً",
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> FaqPage()));
              },
            ),

            const SizedBox(height: 12),

            /// Report Bug
            buildSupportCard(
              context: context,
              icon: Icons.bug_report,
              title: "الإبلاغ عن مشكلة",
              subtitle: "أخبرنا عن أي خطأ في التطبيق",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportBugPage()));

              },

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

