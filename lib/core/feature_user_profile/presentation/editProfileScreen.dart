import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/core/feature_user_profile/presentation/editProfile_form.dart';
import 'package:scholar/core/feature_user_profile/widgets/editProfile_widget.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:scholar/helper/widgets/cached_network_image_view.dart';
import 'package:scholar/helper/widgets/dialogs.dart';
import 'package:scholar/helper/widgets/loading_view.dart';
import 'package:scholar/helper/widgets/svg_view.dart';
import 'package:tuple/tuple.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../cubit_profile/profile_cubit.dart';
import '../provider/profile_provider.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late ProfileProvider _profileProvider;
  String? initialName;
  String? initialEmail;
  String? initialPhone ;
  String? initialPhoto ;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    initialName = _profileProvider.userObject.user?.name ?? "";
    initialEmail = _profileProvider.userObject.user?.email ?? "";
    initialPhone = formatPhone(_profileProvider.userObject.user?.phone);
    initialPhoto = _profileProvider.userObject.user?.photo;
    editProfileForm.patchValue({
      'name': _profileProvider.userObject.user?.name,
      'email': _profileProvider.userObject.user?.email,
      'phone': formatPhone(_profileProvider.userObject.user?.phone),
    });
  }

  String formatPhone(String? phone) {
    if (phone == null || phone.isEmpty) return '';

    if (phone.startsWith('+963')) {
      return phone.substring(4);
    } else if (phone.startsWith('0')) {
      return phone.substring(1);
    }
    print("formatPhone phone $phone");
    return phone;
  }
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (image != null) {
      final dir = await path_provider.getTemporaryDirectory();

      final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
        image.path,
        "${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg",
        quality: 60,
        minWidth: 640,
        minHeight: 480,
      );

      setState(() {
        _profileImage = File(compressedImage != null ? compressedImage.path : image.path,);
        print("_profileImage $_profileImage");
      });
    } else {
      showMessage(context, "لم يتم تحديد صورة", false);
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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

  bool hasChanges() {
    return
      editProfileForm.control('name').value != initialName ||
          editProfileForm.control('email').value != initialEmail ||
          editProfileForm.control('phone').value != initialPhone ||
          _profileImage != null;
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
        print("_profileImage pop  $_profileImage");
          if (didPop) return;
          if (!hasChanges()) {
            Navigator.pop(context);
            return;
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogConfirmExitProfile(profileImage: _profileImage,);
             // return Container();
            },

          );
        },
      child: Scaffold(
        appBar: AppBar(title: const Text("تعديل الحساب"), centerTitle: true),
        body: ReactiveForm(
          formGroup: editProfileForm,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child:  Selector<ProfileProvider, Tuple2<String, LogInModel>>(
              selector: (context, listen) =>
                  Tuple2(listen.imagePath, listen.userObject),
              builder: (_, values, __) {
              return Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // CircleAvatar(
                    //   radius: 70,
                    //   backgroundColor: Colors.grey.shade200,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(70),
                    //     child: _profileImage != null
                    //         ? Image.file(
                    //             _profileImage!,
                    //             width: 140,
                    //             height: 140,
                    //             fit: BoxFit.cover,
                    //           )
                    //         : Center(
                    //       child: SvgPictureView(
                    //         svgPath: "lib/svgFiles/user.svg",
                    //         fit: BoxFit.fitHeight,
                    //         height: 60,
                    //       ),
                    //     )
                    //     // Image.asset(
                    //     //         'assets/images/profilee.jpg',
                    //     //         width: 140,
                    //     //         height: 140,
                    //     //         fit: BoxFit.cover,
                    //     //       )
                    //     ,
                    //   ),
                    // ),
      
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      elevation: 5.0,
                      //  shadowColor: colorThemApp,
                      child: Container(
                        width:  120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:  _profileImage  != null
                            ? Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: Image.file(
                                    _profileImage!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                 // color:  Colors.orange,
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withValues(alpha: 0),
                                        Colors.white.withValues(alpha: 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0, 0.6],
                                      tileMode: TileMode.clamp)),
                            ),
                            // Visibility(
                            //   visible: profileProvider.isFailedUploadImage,
                            //   child: Positioned.fill(child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(120.0),
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         profileProvider.isFailedUploadImage = false;
                            //         profileProvider.uploadImage(context);
                            //       },
                            //       child: Container(
                            //         color: Colors.black.withValues(alpha: 0.4),
                            //         child: Center(
                            //           child: SvgPictureView(
                            //             svgPath: "lib/svgFiles/reload.svg",
                            //             width: 30,height: 30,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   )),
                            // )
                          ],
                        )
                            : (_profileProvider.userObject.user!.photo!.isNotEmpty )
                            ? GestureDetector(
                          onTap: () => _profileProvider.showAnyDialog(context,(){},
                              widgetReturn: Scaffold(
                                backgroundColor: Colors.transparent,
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
      //                                    shadowColor: Colors.white10,
                                  actions: [
                                    IconButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(CupertinoIcons.clear_thick_circled,size: 25,color: Colors.white,),
                                    )
                                  ],
                                  leading: Container(),
                                ),
                                body: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          child: CachedNetworkImageView(
                                            url: _profileProvider.userObject.user!.photo,
                                          )),
                                    )),
                              )
                          ),
                          child: Center(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(120),
                                  child: CachedNetworkImageView(
                                    url:_profileProvider.userObject.user!.photo,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //color: Colors.orange,
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withValues(alpha: 0.6),
                                            Colors.white.withValues(alpha: 0),
      
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: [0, 0.6],
                                          tileMode: TileMode.clamp)),
                                ),
                                // Visibility(
                                //   visible: ! profileProvider.updateImageProfile,
                                //   child: Positioned.fill(child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(120.0),
                                //     child: Container(
                                //       color: Colors.black.withValues(alpha: 0.4),
                                //       child: Center(
                                //         child: SvgPictureView(
                                //           svgPath: "lib/svgFiles/check.svg",
                                //           width: 35,height: 35,
                                //         ),
                                //       ),
                                //     ),
                                //   )),
                                // ),
                                // BlocConsumer<ProfileCubit,ProfileState>(
                                //   listener: (context,state){
                                //     if(state is ProfileImageUploadFailedState)
                                //       profileProvider.updateImageProfile = true;
                                //   },
                                //   builder: (context , state){
                                //     if(state is ProfileImageUploadFailedState) {
                                //       return Positioned.fill(child: ClipRRect(
                                //         borderRadius: BorderRadius.circular(120.0),
                                //         child: GestureDetector(
                                //           onTap: () {
                                //             // BlocProvider.of<ProfileCubit>(context).updateImageProfile(
                                //             //     context,
                                //             //     profileProvider.userObject.data.id,
                                //             //     profileProvider.userObject.data.firstName,
                                //             //     profileProvider.userObject.data.lastName,
                                //             //     profileProvider.userObject.data.phone,
                                //             //     profileProvider.imagePath);
                                //           },
                                //           child: Container(
                                //             color: Colors.black.withValues(alpha: 0.4),
                                //             child: Center(
                                //               child: SvgPictureView(
                                //                 svgPath: "lib/svgFiles/reload.svg",
                                //                 width: 30,height: 30,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ));
                                //     }
                                //     return Container();
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        )
                            : Center(
                          child: SvgPictureView(
                            svgPath: "lib/svgFiles/client.svg",
                            fit: BoxFit.fitHeight,
                            height: 60,
                          ),
                        )
                        ,
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
                            border: Border.all(color: Colors.white, width: 2),
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
                // Selector<ProfileProvider, Tuple2<String, LogInModel>>(
                //   selector: (context, listen) =>
                //       Tuple2(listen.imagePath, listen.userObject),
                //   builder: (_, values, __) {
                //
                //     print("ProfileProvider values.item1 ${values.item1}");
                //     print("ProfileProvider values.item2 ${values.item2}");
                //     return profileImage(
                //         context,
                //         imageUrl:
                //         // "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxJ8OfJkt8T3UwPLl2KUpjMd2Yq8rFBcvCtw&usqp=CAU"
                //         values.item1);
                //   },
                // ),
                // _profileProvider.space(height: 30),
      
                /// only listen don't return widget
                // BlocListener<ProfileCubit, ProfileState>(
                //   listener: (context, state) {
                //     if (state is ProfileImageSuccessEditState) {
                //       Timer.periodic(Duration(seconds: 1), (timer) {
                //         _profileProvider.updateImageProfile = true;
                //         showMessage(context,"تم تحديث صورة الملف الشخصي بنجاح", false);
                //         timer.cancel();
                //       });
                //     }
                //   },
                //   child: Container(),
                // ),
      
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
                  prefixText: "963+"
                ),
      
                const SizedBox(height: 28),
      
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (_, state) {
                    if (state is ProfileLoadingState) {
                      return LoadingView();
                    }
                    if (state is ProfileErrorState) {
                      return saveData(context);
                    }
                    return saveData(context);
                  },
                ),
      
              ],
            );
        },
      ),
          ),
        ),
      ),
    );
  }


  Widget saveData(BuildContext context) {
    return   SizedBox(
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
        onPressed: () async {
          print("Button Pressed");
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi) ||
              connectivityResult.contains(ConnectivityResult.ethernet))
          {
            print(editProfileForm.valid);

            if (editProfileForm.valid) {

              final name = editProfileForm.control('name').value;
              final email = editProfileForm.control('email').value;
              final phone = "+963${editProfileForm.control('phone').value}";
              print("name $name");
              print("email $email");
              print("phone $phone");
              print("photo ${_profileProvider.userObject.user?.photo}");
              print("_profileImage ${_profileImage}");
              BlocProvider.of<ProfileCubit>(context).updateProfileInfo(
                  context, name, email, phone,
                  _profileImage );//_profileProvider.userObject.user?.photo

            } else {
              editProfileForm.markAllAsTouched();
            }

          }
          else{
            showMessage(context,"تحقق من اتصال الإنترنت", true);
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
    );
  }
}
