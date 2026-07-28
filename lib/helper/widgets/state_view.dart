import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar/helper/widgets/svg_view.dart';

enum StateType{
  error,
  noInternet,
  emptyState
}

class StateView extends StatelessWidget {

 final VoidCallback? function ;
 final StateType? stateType ;
 final String? imagePath;
 final String? imageDescription;
 final String? imageHeader;
 final bool? iconRefresh;

 StateView({this.imageHeader,this.imageDescription , this.function,this.stateType = StateType.emptyState,this.imagePath,
 this.iconRefresh});
  @override
  Widget build(BuildContext context) {

    print("image path $imagePath ");
    return GestureDetector(
      onTap: function,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
           emptyStateNoInternetWidget(),
            errorWidget(),
          ],
        ),
      ),
    );

  }

  Widget emptyStateNoInternetWidget(){
    return Visibility(
      visible: stateType != StateType.error,
      child: Padding(
        padding:  EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Container(
             // color:Colors.red,
              child: SvgPictureView(
                svgPath:stateType == StateType.noInternet
                    ? "lib/svgFiles/no_internet_connection.svg"
                    : imagePath ?? "",
              ),
            ),
            //space(height: 20),
            text(imageHeader ?? "" , isBoldStyle: true ,fontSize: 20),
            space(),
            // text(imageDescription ?? "" , isBoldStyle: false )
            iconRefresh==true?Icon(Icons.refresh,color: Colors.black,size: 20,):Container()
          ],
        ),
      ),
    );
  }
  Widget space({double? height}){
    return SizedBox(
      height: height ?? 10,
    );
  }

 Widget text(
     String txt, {
       double? fontSize,
       Color? color,
       bool isBoldStyle = false,
     }) {
   return Text(
     txt,
     textAlign: TextAlign.center,
     style: TextStyle(
       fontSize: fontSize ?? 18,
       color: color ?? Colors.black,
       fontWeight: isBoldStyle ? FontWeight.bold : FontWeight.normal,
     ),
   );
 }

  Widget errorWidget(){
    return Visibility(
        visible: stateType == StateType.error ,
        child:text('حدث خطأ ما',isBoldStyle: false,fontSize: 20),
    );
  }
}
