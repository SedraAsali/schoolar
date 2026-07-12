import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

Widget buildReactiveTextField({
  required BuildContext context,
  required String formControlName,
  required String label,
  required IconData icon,
  bool isPassword = false,
  bool isVisible = false,
  VoidCallback? onToggleVisibility,
}) {
  return ReactiveTextField<String>(
    style: TextStyle(color:  Theme.of(context).colorScheme.onSecondary,),
    formControlName: formControlName,
    cursorColor:  Theme.of(context).colorScheme.onSecondary,
    cursorRadius: Radius.circular(15),
    cursorOpacityAnimates: true,
    obscureText: isPassword ? !isVisible : false,

    decoration: InputDecoration(

      labelText: label,
      labelStyle: TextStyle(
        color:  Theme.of(context).colorScheme.surfaceDim,
      ),
      prefixIcon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSecondary,
      ),

      suffixIcon: isPassword
          ? IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      )
          : null,

      filled: true,
      fillColor: Theme.of(context).colorScheme.primary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,

      ),
    ),

    validationMessages:
    {
      ValidationMessage.required: (_) => "هذا الحقل مطلوب",
      ValidationMessage.pattern: (_) => 'يسمح بالأحرف فقط',
      ValidationMessage.email: (_) => "أدخل بريد إلكتروني صحيح",
      ValidationMessage.minLength: (_) => "كلمة المرور يجب أن تكون 8 أحرف على الأقل",
      ValidationMessage.number:(_)=>"يجب أن يكون رقماً",
      ValidationMessage.mustMatch:(_)=>" كلمة المرور يجب أن تكون متطابقة"
    }

  );
}