import 'package:reactive_forms/reactive_forms.dart';

final logFormGroup= FormGroup(
    {

      'logInPassword':FormControl<String>
        (validators:[
        Validators.minLength(8),
        Validators.required,

      ]),

      'logInEmail':FormControl<String>
        (validators:[
        Validators.email,
        Validators.required,




      ]),



    },
);