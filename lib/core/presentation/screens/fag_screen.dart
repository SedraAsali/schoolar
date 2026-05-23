import 'package:flutter/material.dart';
import '../../domain/models/fag_modle.dart';
import '../widgets/fag_widget.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  final List<FaqItem> faqList = const [
    FaqItem(
      question: "كيف أستخدم التطبيق؟",
      answer:
      "يمكنك تصفح الأقسام المختلفة واستخدام الخدمات بسهولة من الصفحة الرئيسية.",
    ),
    FaqItem(
      question: "لماذا لا تصلني الإشعارات؟",
      answer:
      "تأكد من تفعيل الإشعارات من إعدادات الهاتف ومن داخل التطبيق.",
    ),
    FaqItem(
      question: "كيف أتواصل مع الدعم؟",
      answer:
      "يمكنك استخدام الرقم أو البريد الإلكتروني من صفحة الدعم.",
    ),
    FaqItem(
      question: "كيف أغير كلمة المرور؟",
      answer:
      "اذهب إلى الحساب > تعديل الحساب ثم أدخل الحقول المطلوبة.",
    ),
    FaqItem(
      question: "هل التطبيق مجاني؟",
      answer:
      "نعم، التطبيق مجاني حالياً مع بعض الميزات الإضافية المستقبلية المدفوعة.",
    ),
    FaqItem(
      question: "لماذا التطبيق بطيء أحياناً؟",
      answer:
      "قد يكون السبب ضعف الإنترنت أو ضغط على السيرفر، حاول إعادة المحاولة لاحقاً.",
    ),
    FaqItem(
      question: "كيف أقوم بتسجيل الخروج؟",
      answer:"من الحساب > تسجيل الخروج.",
    ),
    FaqItem(
      question: "هل يمكن استخدام التطبيق بدون إنترنت؟",
      answer:
      "بعض الميزات تعمل بدون إنترنت، لكن معظم الخدمات تحتاج اتصال.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأسئلة الشائعة"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return FaqTile(item: faqList[index]);
        },
      ),
    );
  }
}