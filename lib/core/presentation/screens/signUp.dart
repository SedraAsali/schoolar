import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/presentation/screens/logIn.dart';
import 'package:scholar/core/presentation/screens/signUp_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary ,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.3,
                  child:
                  Image.asset('assets/images/log.png',
                    height:560,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 760,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(120)),

                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25,
                      left: 25,
                      right: 25
                  ),
                  child: Column(
                    children: [
                      Center(
                          child: Text('إنشاء حساب جديد',
                            style: TextStyle(fontSize: 23,
                              color:  Theme.of(context).colorScheme.primary,
                            ),)),
                      SizedBox(height: 35,),
                      ReactiveForm(
                        formGroup: signFormGroup,
                        child: Column(
                          children: [
                            ReactiveTextField<String>(
                              style: TextStyle(color: Theme.of(context).colorScheme.surface),

                              formControlName: 'name',
                              decoration:  InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary,
                                filled: true,
                                labelText: 'الاسم',
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface,),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(120)
                                  ),
                                ),
                              ),
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                'الاسم مطلوب',
                                ValidationMessage.pattern: (_) =>
                                'يسمح بالأحرف فقط',
                              },
                            ),
                            const SizedBox(height: 25),
                            // Email Field
                            ReactiveTextField<String>(
                              style: TextStyle(color: Theme.of(context).colorScheme.surface),

                              formControlName: 'signUpEmail',
                              decoration:  InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary,
                                filled: true,
                                labelText: 'البريد الإلكتروني',
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(120)
                                  ),
                                ),
                              ),
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                'البريد الإلكتروني مطلوب',
                                ValidationMessage.email: (_) =>
                                'صيغة البريد الإلكتروني غير صحيحة',
                              },
                            ),
                            const SizedBox(height: 25),
                            // Password Field
                            ReactiveTextField<String>(
                              style: TextStyle(color: Theme.of(context).colorScheme.surface),

                              formControlName: 'signUpPassword',
                              obscureText: true,
                              decoration:  InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary,
                                filled: true,
                                labelText: 'كلمة المرور',
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface,),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(120)),

                                ),
                              ),
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                'كلمة المرور مطلوبة',
                                ValidationMessage.minLength: (_) =>
                                'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
                              },
                            ),
                            const SizedBox(height: 25),
                            // Confirm Field
                            ReactiveTextField<String>(
                              style: TextStyle(color: Theme.of(context).colorScheme.surface),

                              formControlName: 'confirm',
                              obscureText: true,
                              decoration:  InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary,
                                filled: true,
                                labelText: 'التحقق من كلمة المرور',
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(120)),

                                ),

                              ),
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                'التحقق مطلوب',
                                ValidationMessage.mustMatch: (_) =>
                                'كلمة المرور يجب أن تكون متطابقة',
                              },
                            ),
                            const SizedBox(height: 25),

                            // اختيار مستخدم او مدير
                            ReactiveRadioListTile<String>(
                              formControlName: 'role',
                              value: 'user',
                              title: Text('مستخدم عادي', style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                            ),
                            ReactiveRadioListTile<String>(
                              formControlName: 'role',
                              value: 'admin',
                              title: Text('مدير',
                                style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                            ),

                            const SizedBox(height: 25),
                            // Login Button
                            ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Theme.of(context).colorScheme.surface,

                                    disabledBackgroundColor: Theme.of(context).colorScheme.outline,
                                    disabledForegroundColor:Theme.of(context).colorScheme.surface,
                                  ),
                                  onPressed: formGroup.valid
                                      ? () {
                                    final name =
                                        formGroup.control('name').value;
                                    final email =
                                        formGroup.control('signUpEmail').value;
                                    final password =
                                        formGroup.control('signUpPassword').value;
                                    final role =
                                        formGroup.control('role').value;

                                    debugPrint('Name: $name');
                                    debugPrint('Email: $email');
                                    debugPrint('Password: $password');
                                    debugPrint('Role: $role');
                                  }
                                      : null,
                                  child: const Text('إنشاء الحساب'),
                                );
                              },
                            ),
                            const SizedBox(height: 25),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));
                            }, child: Text('هل قمت بإنشاء حساب مسبقاً ؟ انقر هنا ..'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
