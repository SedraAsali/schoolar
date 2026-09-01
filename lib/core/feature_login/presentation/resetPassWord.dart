 import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_login/presentation/resetPassWord_form.dart';

import '../../../helper/show_message.dart';
import '../../../helper/widgets/loading_view.dart';

class ResetPasswordPage extends StatefulWidget {
const ResetPasswordPage({super.key});

@override
State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
bool obscurePassword = true;
bool obscureConfirmPassword = true;

@override
void initState() {
super.initState();

resetPasswordForm.control('password')
..reset()
..markAsUntouched();

resetPasswordForm.control('confirmPassword')
..reset()
..markAsUntouched();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Theme.of(context).colorScheme.onPrimary,

appBar: AppBar(
backgroundColor: Theme.of(context).colorScheme.primary,
title: const Text(
'إعادة تعيين كلمة المرور',
),
),

body: bodyResetPassword(context),
);
}

Widget bodyResetPassword(BuildContext context) {
return SafeArea(
child: Padding(
padding: const EdgeInsets.only(
top: 10,
right: 25,
left: 25,
),

child: ReactiveForm(
formGroup: resetPasswordForm,

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [


Text(
'إعادة تعيين كلمة المرور',
style: Theme.of(context).textTheme.headlineSmall,
),

const SizedBox(height: 40),

Text(
'أدخل كلمة المرور الجديدة ثم قم بتأكيدها لإعادة تعيين كلمة المرور الخاصة بحسابك.',
style: Theme.of(context).textTheme.bodyLarge,
),

const SizedBox(height: 35),

fieldPassword(context),

const SizedBox(height: 20),


fieldConfirmPassword(context),

const SizedBox(height: 35),


buttonResetPassword(context),
],
),
),
),
);
}


Widget fieldPassword(BuildContext context) {
return ReactiveTextField<String>(
formControlName: 'password',

obscureText: obscurePassword,

cursorColor: Theme.of(context).colorScheme.onPrimary,

cursorRadius: const Radius.circular(10),

cursorOpacityAnimates: true,

style: TextStyle(
color: Theme.of(context).colorScheme.surface,
),

decoration: InputDecoration(
hintText: 'كلمة المرور الجديدة..',

hintStyle: TextStyle(
color: Theme.of(context).colorScheme.surface,
),

prefixIcon: Icon(
Icons.lock_outline,
color: Theme.of(context).colorScheme.surface,
),

suffixIcon: IconButton(
onPressed: () {
setState(() {
obscurePassword = !obscurePassword;
});
},
 icon: Icon(
obscurePassword
? Icons.visibility_off_outlined
    : Icons.visibility_outlined,

color: Theme.of(context).colorScheme.surface,
),
),

fillColor: Theme.of(context).colorScheme.primary,

border: const OutlineInputBorder(
borderSide: BorderSide.none,

borderRadius: BorderRadius.only(
topLeft: Radius.circular(120),
),
),
),

validationMessages: {
ValidationMessage.required: (_) =>
'أدخل كلمة المرور الجديدة',

ValidationMessage.minLength: (_) =>
'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
},
);
}

Widget fieldConfirmPassword(BuildContext context) {
return ReactiveTextField<String>(
formControlName: 'confirmPassword',

obscureText: obscureConfirmPassword,

cursorColor: Theme.of(context).colorScheme.onPrimary,

cursorRadius: const Radius.circular(10),

cursorOpacityAnimates: true,

style: TextStyle(
color: Theme.of(context).colorScheme.surface,
),

decoration: InputDecoration(
hintText: 'تأكيد كلمة المرور..',

hintStyle: TextStyle(
color: Theme.of(context).colorScheme.surface,
),

prefixIcon: Icon(
Icons.lock_outline,
color: Theme.of(context).colorScheme.surface,
),

suffixIcon: IconButton(
onPressed: () {
setState(() {
obscureConfirmPassword =
!obscureConfirmPassword;
});
},

icon: Icon(
obscureConfirmPassword
? Icons.visibility_off_outlined
    : Icons.visibility_outlined,

color: Theme.of(context).colorScheme.surface,
),
),

fillColor: Theme.of(context).colorScheme.primary,

border: const OutlineInputBorder(
borderSide: BorderSide.none,

borderRadius: BorderRadius.only(
topLeft: Radius.circular(120),
),
),
),

validationMessages: {
ValidationMessage.required: (_) =>
'أكد كلمة المرور',

ValidationMessage.mustMatch: (_) =>
'كلمة المرور غير متطابقة',
},
);
}

Widget buttonResetPassword(BuildContext context) {
return Center(
child: ReactiveFormConsumer(
builder: (context, form, child) {
return ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor:
Theme.of(context).colorScheme.primary,

foregroundColor: Colors.white,

disabledBackgroundColor:
Theme.of(context).colorScheme.outline,

disabledForegroundColor: Colors.white,
),

onPressed: () {
// إظهار أخطاء التحقق
form.markAllAsTouched();

// إذا كان النموذج غير صحيح
if (!form.valid) {
return;
}

final password =
form.control('password').value;

final confirmPassword =
form.control('confirmPassword').value;

debugPrint(
'password: $password',
);

debugPrint(
'confirmPassword: $confirmPassword',
);

 // context.read<ResetPasswordBloc>().add(
//   ResetPasswordEventRequest(
//     password: password,
//     confirmPassword: confirmPassword,
//   ),
// );
},

child: const Text(
'إعادة التعيين',
),
);
},
),
);
}
}