

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/cubit_profile/profile_cubit.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:scholar/helper/widgets/loading_view.dart';

import '../../core/feature_user_profile/presentation/editProfile_form.dart';

class DialogLeaveAndLogOut extends StatefulWidget {
  final bool isDialogLogOut;
  final Function logOutFunction;
//  final Function leaveFunction;

  DialogLeaveAndLogOut(
      {required this.isDialogLogOut, required this.logOutFunction,  });//required this.leaveFunction

  @override
  _DialogLeaveAndLogOutState createState() => _DialogLeaveAndLogOutState();
}

class _DialogLeaveAndLogOutState extends State<DialogLeaveAndLogOut> {
  late Widget titleLogOut;
  late Widget subtitleLogOut;
  // late Widget titleLeaveRestaurant;
  @override
  void initState() {
    titleLogOut = title("تسجيل الخروج من الحساب");
    subtitleLogOut = subtitle("هل تريد حقًا تسجيل الخروج من هذا الحساب");
  //  titleLeaveRestaurant = title("do_you_want_to_leave_the_restaurant");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      insetPadding: EdgeInsets.all(20.0),
      child: body(),
    );
  }

  Widget body() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, top: 15.0, right: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Center(child: SvgPicture.asset('lib/svgFiles/iconLogout.svg')),
           titleLogOut ,
          Container() ,
           subtitleLogOut,
           Container() ,
          space(size: 10),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState)
                return LoadingView();
              else {
                return Transform.translate(
                  offset: Offset(10, 0),
                  child: Row(
                    mainAxisAlignment:widget.isDialogLogOut ?
                    MainAxisAlignment.spaceAround:MainAxisAlignment.end,

                    children: [
                      button(
                          buttonText: "cancel",
                          colorText: Colors.black,
                          onPressed: () {
                            if(widget.isDialogLogOut) {
                              Provider.of<ProfileProvider>(context,listen: false).isLogOut = false;
                            }
                            Navigator.of(context).pop();
                          }),
                      button(
                          buttonText: "ok",
                          colorText: Colors.blue,
                          onPressed:  widget.logOutFunction),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget title(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(  fontWeight: FontWeight.bold,
            color:Colors.black,
            fontSize: 18.0,height: 1.2),
        textAlign: TextAlign.start,
      ),
    );
  }
  Widget subtitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 13.0,color: Colors.black,fontFamily: "regular",height: 1.2),
        textAlign: TextAlign.center,
      ),
    );
  }



  Widget space({double size = 10.0}) {
    return SizedBox(height: size);
  }

  Widget button({required String buttonText,required Color colorText, required   onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange,
          fontSize: 15.0,
          height: 1.2,
        ),
      ),
    );
  }
}


// DialogConfirmExitExternal
class DialogConfirmExitExternal extends StatefulWidget {
 final File? profileImage;
  const DialogConfirmExitExternal({super.key,required this.profileImage});
  @override
  _DialogConfirmExitExternalState createState() => _DialogConfirmExitExternalState();
}

class _DialogConfirmExitExternalState extends State<DialogConfirmExitExternal> {

  Widget? titleConfirmExit;



  @override
  void initState() {
    titleConfirmExit = title("هل تريد حفظ تعديلات ؟");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        insetPadding: EdgeInsets.all(20.0),
        child: body(),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, top: 15.0, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(),
          Container(),
          Container(),

          titleConfirmExit!,

          BlocBuilder<ProfileCubit, ProfileState>(
              builder: (_, state) {
                if (state is ProfileLoadingState) {
                  return LoadingView();
                }
              return saveData();
            }
          )
        ],
      ),
    );
  }

  Widget title(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget button({
    String? buttonText,
    Color? colorText,
    VoidCallback? onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colorText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        buttonText ?? '',
        style: TextStyle(
          fontSize: 16,
          color: colorText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget saveData() {
    print("_profileImage dialog ${widget.profileImage}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        button(
            buttonText: "cancel",
            colorText: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }),
        button(
          buttonText: "ok",
          colorText: Colors.blue,
          onPressed:() async {
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

                print("_profileImage dialog ${widget.profileImage}");
                BlocProvider.of<ProfileCubit>(context).updateProfileInfo(
                    context, name, email, phone,
                    widget.profileImage ).then((value){
                      print("value dialoglog $value");
                      if(value==200)
                        {
                          Navigator.of(context).pop();
                        }
                });//_profileProvider.userObject.user?.photo

              } else {
                editProfileForm.markAllAsTouched();
              }

            }
            else{
              showMessage(context,"تحقق من اتصال الإنترنت", true);
            }


          },)
      ],
    );
  }


}