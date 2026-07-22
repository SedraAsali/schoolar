import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/cubit_profile/profile_cubit.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/global_variable_provide.dart';
import 'package:scholar/helper/widgets/cached_network_image_view.dart';
import 'package:scholar/helper/widgets/svg_view.dart';

class ProfileImage extends StatefulWidget {
  final String imageUrl;
  final Function? onTap;


  ProfileImage({required this.imageUrl, this.onTap });

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider,GlobalVariableProvider>(
      builder: (_, profileProvider,globalProvider ,__) {
        print("profile Image  profileProvider.image ${ profileProvider.image}");
        print("profileProvider.imagePath ${profileProvider.imagePath}  ${profileProvider.imagePath.isNotEmpty}" );
        return Stack(
          children: [
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
                child: profileProvider.image != null
                    ? Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.file(
                            profileProvider.image!,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  Colors.orange,
                          gradient: LinearGradient(
                              colors: [
                                Colors.orange.withValues(alpha: 0.6),
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
                    : (profileProvider.imagePath.isNotEmpty )
                    ? GestureDetector(
                      onTap: () => profileProvider.showAnyDialog(context,(){},
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
                                    url: widget.imageUrl,
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
                            url: widget.imageUrl,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                              gradient: LinearGradient(
                                  colors: [
                                     Colors.orange.withValues(alpha: 0.6),
                                    Colors.orange.withValues(alpha: 0),

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
                ),
              ),
            ),
            // Visibility(
            //   visible: profileProvider.isUploadingImage,
            //   child: Positioned.fill(
            //     child: Transform.scale(
            //       scale: 1.05,
            //       child: CircularProgressIndicator(
            //         backgroundColor: Colors.orange,
            //         strokeWidth: 2.5,
            //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.5),
                    shape: BoxShape.circle),
                margin: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(180),
                    onTap: () {
                      widget.onTap?.call();
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
