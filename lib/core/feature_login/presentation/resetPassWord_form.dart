import 'package:reactive_forms/reactive_forms.dart';

final FormGroup resetPasswordForm = FormGroup(
  {
    'password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),

    'confirmPassword': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  },
  validators: [
    Validators.mustMatch(
      'password',
      'confirmPassword',
    ),
  ],
);