import 'package:reactive_forms/reactive_forms.dart';

final editProfileForm = FormGroup({

  'name': FormControl<String>(
    value: "اسم المستخدم",
    validators: [
      Validators.required,
      Validators.pattern(r'^[a-zA-Zأ-ي ]+$'),
    ],
  ),

  'email': FormControl<String>(
    value: "ScholarAppUser@gmail.com",
    validators: [
      Validators.required,
      Validators.email,
    ],
  ),

  'phone': FormControl<String>(
    value: "950062418",
    validators: [
      Validators.required,
      Validators.number(),
      Validators.pattern(r'^9\d{8}$'),
    ],
  ),

  // 'oldPassword': FormControl<String>(
  //   validators: [
  //     Validators.required,
  //   ],
  // ),
  //
  // 'newPassword': FormControl<String>(
  //   validators: [
  //     Validators.required,
  //     Validators.minLength(8),
  //   ],
  // ),

  // 'confirmPassword': FormControl<String>(
  //   validators: [
  //     Validators.required,
  //   ],
  // ),
},

//  مقارنة كلمة المرور الصحيحة
//   validators: [
//     Validators.mustMatch('newPassword', 'confirmPassword'),
//   ],
);