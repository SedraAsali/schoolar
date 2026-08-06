import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_login/presentation/LogInView.dart';
import 'package:scholar/core/feature_signup/presentation/signUp_form.dart';
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/global_variable_provide.dart';

import '../../../helper/text_field_provider.dart';
import '../../feature_home/presentation/home_screen_view.dart';
import '../../feature_login/presentation/login_form.dart' show logFormGroup;
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/signUp.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}
class _SignUpViewState extends State<SignUpView>  {


  late GlobalVariableProvider globalVariableProvider;
  ConfigClass configClass = ConfigClass();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode passwordConfirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordFocus.addListener(() {
      setState(() {});
    });
    passwordConfirmFocus.addListener(() {
      setState(() {});
    });
    BlocProvider.of<SignUpBloc>(context).add(SignUpInit());
    globalVariableProvider =Provider.of<GlobalVariableProvider>(context, listen: false);
  }
  @override
  void dispose() {
    passwordFocus.dispose();
    passwordConfirmFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return signupView(context);
  }

  Widget signupView(BuildContext context){
    return Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary ,

        body:signupBody(context));
  }


  Widget signupBody(BuildContext context){
    return  SafeArea(
      child: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
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
              // credentialsInput()
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpDone) {

                    Provider.of<GlobalVariableProvider>(context, listen: false).setSignInValues(true);

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreenView()),
                            (Route<dynamic> route) => false);
                    BlocProvider.of<SignUpBloc>(context).add(SignUpInit());

                  }
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
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
    return   Container(
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
            SizedBox(height: 20,),
            ReactiveForm(
              formGroup: signFormGroup,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    cursorRadius: Radius.circular(10),
                    cursorOpacityAnimates: true,
                    formControlName: 'name',
                    decoration:  InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      hintText: 'الاسم',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface,),
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
                  const SizedBox(height: 18),
                  //phone
                  ReactiveTextField<String>(
                    formControlName: 'number',
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    cursorRadius: Radius.circular(10),
                    cursorOpacityAnimates: true,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      hintText: 'رقم الهاتف',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),

                      prefixIcon: Container(
                        width: 95,
                        alignment: Alignment.center,
                        child: const Text(
                          '🇸🇾 +963',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(120),
                        ),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) => 'رقم الهاتف مطلوب',
                      ValidationMessage.pattern: (_) =>
                      ' أدخل رقم هاتف سوري صحيح و لا يبدأ بالصفر',
                    },
                  ),
                  const SizedBox(height: 18),
                  // Email Field
                  ReactiveTextField<String>(
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),

                    formControlName: 'signUpEmail',
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    cursorRadius: Radius.circular(10),
                    cursorOpacityAnimates: true,
                    decoration:  InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      hintText: 'البريد الإلكتروني',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
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
                  const SizedBox(height: 18),
                  // Password Field
                  Consumer<TextFieldProvider>(
                    builder: (context, values, child) {

                      return ReactiveValueListenableBuilder<String>(
                        formControlName: 'signUpPassword',
                        builder: (context, control, child){
                           final hasText = (control.value?.isNotEmpty ?? false);

                          return ReactiveTextField<String>(
                         style: TextStyle(color: Theme.of(context).colorScheme.surface),

                    formControlName: 'signUpPassword',
                            cursorColor: Theme.of(context).colorScheme.onPrimary,
                            cursorRadius: Radius.circular(10),
                            cursorOpacityAnimates: true,
                    obscureText: !values.passwordIsLookAtPassword,
                   focusNode: passwordFocus,
                    decoration:  InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      hintText: 'كلمة المرور',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface,),
                      suffixIcon:passwordFocus.hasFocus || hasText? Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: IconButton(
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
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: hasText ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.outlineVariant,
                            size: 20,
                          ),
                        ),
                      ):null,
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
                  );
  },
);
  },
),
                  const SizedBox(height: 18),
                  // Confirm Field
                  Consumer<TextFieldProvider>(
                    builder: (context, values1, child){
                   return    ReactiveValueListenableBuilder<String>(
                       formControlName: 'confirm',
                       builder: (context, control1, child) {
                         final hasText = (control1.value?.isNotEmpty ?? false);

                         return ReactiveTextField<String>(
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),

                        formControlName: 'confirm',
                           cursorColor: Theme.of(context).colorScheme.onPrimary,
                           cursorRadius: Radius.circular(10),
                           cursorOpacityAnimates: true,
                        obscureText: !values1.confirmIsLookAtPassword,
                        focusNode: passwordConfirmFocus,
                        decoration:  InputDecoration(
                          fillColor: Theme.of(context).colorScheme.primary,
                          filled: true,
                          hintText: 'التحقق من كلمة المرور',
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
                          suffixIcon:passwordConfirmFocus.hasFocus || hasText? Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: IconButton(
                              onPressed: hasText
                                  ? () {
                                values1.changeBoolState(!values1.confirmIsLookAtPassword, 2);
                              }
                                  : null,
                              icon: Icon(
                                values1.confirmIsLookAtPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: hasText ?Theme.of(context).colorScheme.surface
                                    : Theme.of(context).colorScheme.outlineVariant,
                                size: 20,
                              ),
                            ),
                          ):null,
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
                                         );
                     }
                   );
  },
),

                  // اختيار مستخدم او مدير
                  Material(
                    type: MaterialType.transparency,
                    child: ReactiveRadioListTile<String>(
                      formControlName: 'role',
                      value: 'USER',
                      title: Text('مستخدم عادي', style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: ReactiveRadioListTile<String>(
                      formControlName: 'role',
                      value: 'MANAGER',
                      title: Text('مدير',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Login Button
                  SignupButton(), TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LogInView()));
                  }, child: Text('هل قمت بإنشاء حساب مسبقاً ؟ انقر هنا ..'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SignupButton() {
    return ReactiveFormConsumer(
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
            final phone =
               "+963${formGroup.control('number').value}";
            final password =
                formGroup.control('signUpPassword').value;
            final role =
                formGroup.control('role').value;

            debugPrint('Name: $name');
            debugPrint('Email: $email');
            debugPrint('phone: $phone');
            debugPrint('Password: $password');
            debugPrint('Role: $role');

            if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && password.isNotEmpty && role.isNotEmpty) {
              BlocProvider.of<SignUpBloc>(context)
                  .add(SignUpCall(
                  context,name,email,phone,
                  password, role
              ));
            }
          }
              : null,
          child: const Text('إنشاء الحساب'),
        );
      },
    );
  }





}
