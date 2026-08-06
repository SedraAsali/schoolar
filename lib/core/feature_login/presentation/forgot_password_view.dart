import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'forgotPassWord_form.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('استعادة كلمة المرور'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 90,
            right: 25,
            left: 25
          ),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نسيت كلمة المرور !!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 40),

                Text(
                  'أدخل البريد الإلكتروني المرتبط بالحساب، وسنرسل لك تعليمات إعادة تعيين كلمة المرور.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 35),

                ReactiveTextField<String>(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  cursorRadius: Radius.circular(10),
                  cursorOpacityAnimates: true,
                  formControlName: 'email',
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني..',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.surface
                    ),
                    prefixIcon:  Icon(Icons.person_outline,
                      color: Theme.of(context).colorScheme.surface
                    ,),
                    fillColor: Theme.of(context).colorScheme.primary,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(topLeft:  Radius.circular(120)
                        ),
                    ),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                    'هذا الحقل مطلوب',
                    ValidationMessage.email: (_) =>
                    'صيغة البريد الإلكتروني غير صحيحة',
                  },
                ),

                const SizedBox(height: 35),

                Center(
                  child: SizedBox(
                    child: ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            disabledBackgroundColor: Theme.of(context).colorScheme.outline,
                            disabledForegroundColor:Theme.of(context).colorScheme.surface,

                          ),
                          onPressed: form.valid
                              ? () {
                            final value = form.control('email').value;
                            debugPrint(value);

                          }
                              : null,
                          child: const Text('إرسال'),
                        );
                      },
                    ),
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