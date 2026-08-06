
import 'package:reactive_forms/reactive_forms.dart';

final FormGroup form = FormGroup({
  'email': FormControl<String>(
    validators: [
      Validators.email,
      Validators.required,
    ],
  ),
});
