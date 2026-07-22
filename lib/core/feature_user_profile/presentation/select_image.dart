import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/widgets/svg_view.dart';


/// Select Image UI
///

class SelectImageFormBottomSheet extends StatefulWidget {
  @override
  _SelectImageFormBottomSheetState createState() =>
      _SelectImageFormBottomSheetState();
}

class _SelectImageFormBottomSheetState
    extends State<SelectImageFormBottomSheet> {
  late ProfileProvider _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * .25,
      child: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileProvider.space(height: 20),
              _profileProvider.notch(context),
              _profileProvider.space(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 0  ,right: 20 ),
                child: _profileProvider.title("اختر صورة من"),
              ),
              _profileProvider.space(height: 20),
              typeSourceSelectImage(
                context,
                sourceTitle: "الكاميرا",
                sourceSvgPath: "lib/svgFiles/action-camera.svg",
                onTap: () async {
                  await _profileProvider.getImagePicker(
                      ImageSourcePicker.Camera, context);
                },
              ),
              typeSourceSelectImage(
                context,
                sourceTitle: "معرض الصور",
                sourceSvgPath: "lib/svgFiles/image-gallery.svg",
                onTap: () async {
                  _profileProvider.getImagePicker(
                      ImageSourcePicker.Gallery, context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget typeSourceSelectImage(BuildContext context,
      {required String sourceTitle,
        required sourceSvgPath,
        required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: 0  ,right:  10 ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(

          padding: const EdgeInsets.only(

            top: 5,

            bottom: 5,

            left: 0,

            right: 10,

          ),

          shape: const RoundedRectangleBorder(

            borderRadius: BorderRadius.only(

              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),

        ),
        child: Row(
          children: [
            SvgPictureView(
              svgPath: sourceSvgPath,
              height: 35,
              width: 35,
            ),
            SizedBox(
              width: 20,
            ),
            _profileProvider.title(
                sourceTitle, Colors.black,20),
          ],
        ),
      ),
    );
  }
}