import 'package:flutter/material.dart';
import 'package:scholar/core/feature_user_profile/widgets/editProfile_widget.dart';
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

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
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

                  onPressed: () {
                    if (editProfileForm.valid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
                      );

                      Navigator.pop(context);
                    } else {
                      editProfileForm.markAllAsTouched();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
