import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_signup/presentation/SignUpView.dart';
//import 'package:restorant/Helper/ConfigClass.dart';
//import 'package:restorant/Helper/SharedPreferencesHelper.dart';
//import 'package:restorant/Widget/constant.dart';

//import 'package:restorant/providers/global_variable_provide.dart';

import '../../../helper/text_field_provider.dart';
import '../../feature_login/presentation/login_form.dart' show logFormGroup;
import '../../presentation/screens/home_screen.dart';
import 'bloc/log_in_bloc.dart';

class LogInView extends StatefulWidget {
  @override
  _LogInViewState createState() => _LogInViewState();
}
class _LogInViewState extends State<LogInView>  {




  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogInBloc>(context).add(LogInInit());

  }///
  @override
  Widget build(BuildContext context) {
    //globalVariableProvider=Provider.of<GlobalVariableProvider>(context);
    return logInView(context);
  }
  Widget logInView(BuildContext context){
    return Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary ,

        body:signInBody(context));
  }
  

  Widget signInBody(BuildContext context){
    return  SafeArea(
      child: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
              children: <Widget>[
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
               // credentialsInput()
                BlocListener<LogInBloc, LogInState>(
                  listener: (context, state) {
                    if (state is LogInDone) {

                 // Provider.of<GlobalVariableProvider>(context, listen: false)
                  //  ..setSignInValues(true);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false);
                    BlocProvider.of<LogInBloc>(context).add(LogInInit());
                   //    Navigator.pushReplacement(
                   //      context,
                   //      MaterialPageRoute(builder: (_) => HomeScreen()),
                   //    );
                    }
                  },
                  child: BlocBuilder<LogInBloc, LogInState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          credentialsInput(),

                          if (state is Loading)
                            Container(),
                        ],
                      );
                    },
                  ),
                )


              ],
            ),
        ),

      ),
    );
  }
  

  Widget credentialsInput(){
    return Container(
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
        child: SingleChildScrollView(
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
                      style: TextStyle(color: Theme.of(context).colorScheme.surface),
                      formControlName: 'logInEmail',
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
                    Consumer<TextFieldProvider>(
                      builder: (context, values, child) {
                        return ReactiveValueListenableBuilder<String>(
                          formControlName: 'logInPassword',
                          builder: (context, control, child) {
                            final hasText = (control.value?.isNotEmpty ?? false);

                            return ReactiveTextField<String>(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              formControlName: 'logInPassword',
                              obscureText: !values.passwordIsLookAtPassword,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                labelText: 'كلمة المرور',

                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 48,
                                  minHeight: 48,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: hasText
                                      ? () {
                                    values.changeBoolState(
                                      !values.passwordIsLookAtPassword,
                                      1,
                                    );
                                  }
                                      : null,
                                  icon: Icon(
                                    values.passwordIsLookAtPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: hasText ? Colors.white : Colors.grey,
                                  ),
                                ),

                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(120),
                                  ),
                                ),
                              ),
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                'كلمة المرور مطلوبة',
                                ValidationMessage.minLength: (_) =>
                                'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
                              },
                            );
                          },
                        );
                      },
                    ),
                    TextButton(onPressed: (){},
                        child: Text('هل نسيت كلمة المرور !؟',)),

                    const SizedBox(height: 40),
                    logInButton(),
                    const SizedBox(height: 20),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpView()));
                    }, child: Text('إذا كنت لا تمتلك حساب مسبق ؟ انقر هنا ..'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logInButton(){
    return  ReactiveFormConsumer(
      builder: (context, formGroup, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,

            disabledBackgroundColor: Theme.of(context).colorScheme.outline,
            disabledForegroundColor:Theme.of(context).colorScheme.surface,
          ),

          onPressed: formGroup.valid
              ?
              () {
            final email =
                formGroup.control('logInEmail').value;

            final password =
                formGroup.control('logInPassword').value;

            debugPrint('Email11: $email');
            debugPrint('Password: $password');
            if (email.isNotEmpty &&
                password.isNotEmpty) {
                BlocProvider.of<LogInBloc>(context)
                  .add(LogInCall(
                      context,
                      password,
                    email,
                      ));
              }
          }
              : null,

          child: const Text('تسجيل الدخول'),
        );
      },
    );
  }



}
