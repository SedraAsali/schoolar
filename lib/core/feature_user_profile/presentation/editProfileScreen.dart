import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_user_profile/widgets/editProfile_widget.dart';

import 'editProfile_form.dart';

class EditProfilePage extends StatefulWidget {
const EditProfilePage({super.key});

@override
State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
bool oldPasswordVisible = false;
bool newPasswordVisible = false;
bool confirmPasswordVisible = false;

final ImagePicker _picker = ImagePicker();
File? _profileImage;

Future<void> _pickImage(ImageSource source) async {
final XFile? image = await _picker.pickImage(
source: source,
imageQuality: 80,
);

if (image != null) {
setState(() {
_profileImage = File(image.path);
});
}
}

void _showImagePicker() {
showModalBottomSheet(
context: context,
shape: const RoundedRectangleBorder(
borderRadius: BorderRadius.vertical(
top: Radius.circular(20),
),
),
builder: (context) {
return SafeArea(
child: Wrap(
children: [
ListTile(
leading: const Icon(Icons.camera_alt),
title: const Text("التقاط صورة"),
onTap: () {
Navigator.pop(context);
_pickImage(ImageSource.camera);
},
),
ListTile(
leading: const Icon(Icons.photo_library),
title: const Text("اختيار من المعرض"),
onTap: () {
Navigator.pop(context);
_pickImage(ImageSource.gallery);
},
),
],
),
);
},
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("تعديل الحساب"),
centerTitle: true,
),
body: ReactiveForm(
formGroup: editProfileForm,
child: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
children: [
Stack(
alignment: Alignment.bottomRight,
children: [
CircleAvatar(
radius: 70,
backgroundColor: Colors.grey.shade200,
child: ClipRRect(
borderRadius: BorderRadius.circular(70),
child: _profileImage != null
? Image.file(
_profileImage!,
width: 140,
height: 140,
fit: BoxFit.cover,
)
    : Image.asset(
'assets/images/profilee.jpg',
width: 140,
height: 140,
fit: BoxFit.cover,
),
),
),
Positioned(
right: 0,
bottom: 0,
child: GestureDetector(
onTap: _showImagePicker,
child: Container(
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: Theme.of(context).colorScheme.primary,
shape: BoxShape.circle,
border: Border.all(
color: Colors.white,
width: 2,
),
),
child: const Icon(
Icons.edit,
color: Colors.white,
size: 20,
),
),
),
),
],
),

const SizedBox(height: 30),

buildReactiveTextField(
context: context,
formControlName: 'name',
label: "اسم المستخدم",
icon: Icons.person,
),

const SizedBox(height: 18),

buildReactiveTextField(
context: context,
formControlName: 'email',
label: "البريد الإلكتروني",
icon: Icons.email,
),

const SizedBox(height: 18),

buildReactiveTextField(
context: context,
formControlName: 'phone',
label: "رقم الهاتف",
icon: Icons.phone,
),

const SizedBox(height: 28),

SizedBox(
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
const SnackBar(
content: Text("تم حفظ التعديلات بنجاح"),
),
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