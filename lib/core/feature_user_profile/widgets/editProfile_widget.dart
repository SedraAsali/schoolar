import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

Widget buildReactiveTextField({
  required BuildContext context,
  required String formControlName,
  required String label,
  required IconData icon,
  bool isPassword = false,
  bool isVisible = false,
  String prefixText = " ",
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
      prefixStyle: TextStyle(color:  Theme.of(context).colorScheme.onSecondary,fontSize: 16),
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
       prefixText:prefixText ,
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
      ValidationMessage.number:(_)=>" يجب أن يكون رقماً يبدأ بالرقم 9 ومؤلف من 9أرقام",
      ValidationMessage.mustMatch:(_)=>" كلمة المرور يجب أن تكون متطابقة"
    }

  );
}