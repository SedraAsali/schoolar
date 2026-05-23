import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'bugReport_form.dart';

class ReportBugPage extends StatelessWidget {
  const ReportBugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإبلاغ عن مشكلة"),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: BugReportForm.form,
          child: SingleChildScrollView(
            child: Column(
              children: [
            SizedBox(height: 5,),
                ReactiveTextField<String>(
                  formControlName: 'title',
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "عنوان المشكلة",

                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
            
                    ),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                    "الرجاء إدخال عنوان المشكلة",
                  },
                ),
            
                const SizedBox(height: 12),
            
                ReactiveTextField<String>(

                  formControlName: 'description',
                  maxLines: 4,
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "وصف المشكلة",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                    "الرجاء إدخال وصف المشكلة",
                  },
                ),
            
                const SizedBox(height: 12),
            
                ReactiveDropdownField<String>(
                  formControlName: 'type',
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "نوع المشكلة",
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),

                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => "الرجاء إدخال نوع المشكلة",},
                  items: BugReportForm.types
                      .map(
                        (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface
                      ),),
                    ),
                  )
                      .toList(),
                ),
            
                const SizedBox(height: 20),
            
                SizedBox(
                  width: double.infinity,
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(

                        onPressed: form.valid
                            ? () {
                          final data = form.value;
            
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم إرسال المشكلة بنجاح"),
                            ),
                          );
            
                          form.reset();
                        }
                            : null,
                        child: const Text("إرسال"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}