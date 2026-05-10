import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'login_form.dart';
import 'signUp.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary ,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                 ClipRRect(
                   child: Align(
                     alignment: Alignment.topCenter,
                     heightFactor: 0.4,
                     child:
                     Image.asset('assets/images/log.png',
                     height:600,
                     fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 Container(
                  height: 460,
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
                            child: Text('تسجيل الدخول',
                            style: TextStyle(fontSize: 23,
                            color:  Theme.of(context).colorScheme.primary,
                    ),)),
                        SizedBox(height: 45,),
                        ReactiveForm(
                          formGroup: logFormGroup,
                          child: Column(
                            children: [
                              // Email Field
                              ReactiveTextField<String>(
                                formControlName: 'logInEmail',
                                decoration:  InputDecoration(
                                  labelText: 'البريد الإلكتروني',
                                  border: OutlineInputBorder(
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
                                formControlName: 'logInPassword',
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'كلمة المرور',
                                  border: OutlineInputBorder(
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
                              const SizedBox(height: 60),
                              // Login Button
                              ReactiveFormConsumer(
                                builder: (context, formGroup, child) {
                                  return ElevatedButton(

                                    onPressed: formGroup.valid
                                        ? () {
                                      final email =
                                          formGroup.control('logInEmail').value;
                                      final password =
                                          formGroup.control('logInPassword').value;

                                      debugPrint('Email: $email');
                                      debugPrint('Password: $password');
                                    }
                                        : null,
                                    child: const Text('تسجيل الدخول'),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                              }, child: Text('إذا كنت لا تمتلك حساب مسبق ؟ انقر هنا ..'))
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
      ),
    );
  }
}
