import 'package:reactive_forms/reactive_forms.dart';

class BugReportForm {
  static final FormGroup form = FormGroup({
    'title': FormControl<String>(
      validators: [Validators.required],
    ),
    'description': FormControl<String>(
      validators: [Validators.required, Validators.minLength(10)],
    ),
    'type': FormControl<String>(
      value: 'مشكلة تقنية',
      validators: [Validators.required],
    ),
  });

  static List<String> types = [
    "مشكلة تقنية",
    "مشكلة تسجيل دخول",
    "خطأ في التطبيق",
    "اقتراح",
  ];
}