import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_login/presentation/resetPassWord.dart';
import '../../../helper/show_message.dart';
import '../../../helper/widgets/loading_view.dart';
import 'forgotPassWord_form.dart';
import 'forgot_password_bloc/forgot_password_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  void initState() {
    super.initState();

    form.control('email')
      ..reset()
      ..markAsUntouched();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('استعادة كلمة المرور'),
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordDone) {
            showMessage(
              context,
              "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
              false,
            );
          }

          if (state is ForgotPasswordNotFound) {
            showMessage(
              context,
              "لا يوجد مستخدم مسجل بهذا البريد الإلكتروني",
              true,
            );
          }

          if (state is ForgotPasswordBadRequest) {
            showMessage(context, "البيانات المدخلة غير صحيحة", true);
          }

          if (state is ForgotPasswordNoInternet) {
            showMessage(context, "تحقق من اتصال الإنترنت", true);
          }

          if (state is ForgotPasswordFailed) {
            showMessage(context, "حدث خطأ ما، يرجى المحاولة مرة أخرى", true);
          }
        },

        child: bodyForgotPassword(context),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ResetPasswordPage()));
      }),
    );
  }

  Widget? bodyForgotPassword(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 90, right: 25, left: 25),
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

              fieldEmail(context),

              const SizedBox(height: 35),

              buttonSend(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldEmail(BuildContext context) {
    return ReactiveTextField<String>(
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      cursorRadius: Radius.circular(10),
      cursorOpacityAnimates: true,
      formControlName: 'email',
      style: TextStyle(color: Theme.of(context).colorScheme.surface),
      decoration: InputDecoration(
        hintText: 'البريد الإلكتروني..',
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        prefixIcon: Icon(
          Icons.person_outline,
          color: Theme.of(context).colorScheme.surface,
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(120)),
        ),
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'أدخل البريد الإلكتروني',
        ValidationMessage.email: (_) => 'صيغة البريد الإلكتروني غير صحيحة',
      },
    );
  }

  Widget buttonSend(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        print("buttonSend state $state");
        if (state is ForgotPasswordLoading) {
          return LoadingView();
        }
        return Center(
          child: SizedBox(
            child: ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.outline,

                    disabledForegroundColor: Colors.white,
                  ),
                  onPressed: () {
                    form.markAllAsTouched();
                    if (!form.valid) {
                      return;
                    }
                    final email = form.control('email').value;
                    debugPrint("email $email");
                    if (email.isNotEmpty) {
                      context.read<ForgotPasswordBloc>().add(
                        ForgotPasswordEventRequest(
                          email: email,
                          //context: context,
                        ),
                      );
                    }
                  },
                  child: const Text('إرسال'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
