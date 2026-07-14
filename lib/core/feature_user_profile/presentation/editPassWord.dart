import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/core/feature_user_profile/widgets/editProfile_widget.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:scholar/helper/widgets/loading_view.dart';
import '../cubit_profile/profile_cubit.dart';
import 'editProfile_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditPassWord extends StatefulWidget {
  const EditPassWord({super.key});

  @override
  State<EditPassWord> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditPassWord> {
  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
    editProfileForm.control('oldPassword')..reset()..markAsUntouched();

    editProfileForm.control('newPassword')..reset()..markAsUntouched();

    editProfileForm.control('confirmPassword')..reset()..markAsUntouched();
  }

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("تغيير كلمة السر"), centerTitle: true),

      body: ReactiveForm(
        formGroup: editProfileForm,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              /// كلمة المرور القديمة
              buildReactiveTextField(
                context: context,
                formControlName: 'oldPassword',
                label: "كلمة المرور القديمة",
                icon: Icons.lock_outline,
                isPassword: true,
                isVisible: oldPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    oldPasswordVisible = !oldPasswordVisible;
                  });
                },
              ),

              const SizedBox(height: 18),

              /// كلمة المرور الجديدة
              buildReactiveTextField(
                context: context,
                formControlName: 'newPassword',
                label: "كلمة المرور الجديدة",
                icon: Icons.lock,
                isPassword: true,
                isVisible: newPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    newPasswordVisible = !newPasswordVisible;
                  });
                },
              ),

              const SizedBox(height: 18),

              /// تأكيد كلمة المرور
              buildReactiveTextField(
                context: context,
                formControlName: 'confirmPassword',
                label: "تأكيد كلمة المرور",
                icon: Icons.lock_reset,
                isPassword: true,
                isVisible: confirmPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                },
              ),

              const SizedBox(height: 35),

              /// زر الحفظ
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (_, state)  {
                  print ("state $state");
                  if (state is ProfileLoadingState) {
                    return LoadingView();
                  }
                  if (state is ProfileSuccessChangePasswordState)
                  {
                    print ("successsss");
                    editProfileForm.patchValue({
                      'oldPassword': '',
                      'newPassword': '',
                      'confirmPassword': '',
                    });
                    return  saveData(context,state);
                  }
                  print ("failedd");
                  return  saveData(context,state);//ProfileFailedChangePasswordState

  },
),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveData(BuildContext context, ProfileState state) {

    return SizedBox(
      //width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        onPressed: () async{
          var connectivityResult = await Connectivity().checkConnectivity();

          if (connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi) ||
              connectivityResult.contains(ConnectivityResult.ethernet))
          {
            if (editProfileForm.valid) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
              // );
              final oldPassword = editProfileForm.control('oldPassword').value;
              final newPassword = editProfileForm.control('newPassword').value;
              final confirmPassword = editProfileForm.control('confirmPassword').value;
              print("oldPassword $oldPassword");
              print("newPassword$newPassword");
              print("confirmPassword $confirmPassword");
              BlocProvider.of<ProfileCubit>(context).changePassword(context,
                  oldPassword, newPassword);

              // editProfileForm.patchValue({
              //   'oldPassword': '',
              //   'newPassword': '',
              //   'confirmPassword': '',
              // });
              //  Navigator.pop(context);
            } else
            {
              editProfileForm.markAllAsTouched();
            }
          }
          else{
            showMessage(context,"تحقق من اتصال الإنترنت", true);
          }

        },

        icon: Icon(
          Icons.save,
          color: Theme.of(context).colorScheme.surface,
        ),
        label: Text(
          "حفظ التعديلات",
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
