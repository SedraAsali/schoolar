

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/cubit_profile/profile_cubit.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/widgets/loading_view.dart';

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