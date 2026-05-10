import 'package:reactive_forms/reactive_forms.dart';

final signFormGroup= FormGroup(
    {
      'name':FormControl<String>
        (
        validators: [
          Validators.required,
          Validators.pattern(r'^[a-zA-Zأ-ي ]+$'),
        ],
      ),

      'role': FormControl<String>(
        validators: [Validators.required],
      ),

      'signUpPassword':FormControl<String>
        (validators:[
        Validators.minLength(8),
        Validators.required,

      ]),


      'signUpEmail':FormControl<String>
        (validators:[
        Validators.email,
        Validators.required,


      ]),

      'confirm':FormControl<String>
        (validators:[
        Validators.required,
      ]),

    },
    validators:[
      Validators.mustMatch('signUpPassword', 'confirm'),

    ]
);