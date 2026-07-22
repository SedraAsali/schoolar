import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPictureView extends StatelessWidget {
  String svgPath;
  double? width ;
  double? height ;
  BoxFit? fit;
  Color? coloSvg ;
  VoidCallback? function ;
  Alignment? alignment;
  SvgPictureView({required this.svgPath ,
    this.alignment, this.width ,this.height ,
    this.function ,this.fit ,this.coloSvg});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function ,
      child: SvgPicture.asset(svgPath,height: height,
        alignment: alignment ?? Alignment.center,
        width: width,fit: fit ?? BoxFit.contain,color: coloSvg,),
    );
  }
}
class NetworkSvgView extends StatelessWidget {
  String svgPath;
  VoidCallback? function ;

  NetworkSvgView({required this.svgPath , this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: SvgPicture.network(svgPath),
    );
  }
}
