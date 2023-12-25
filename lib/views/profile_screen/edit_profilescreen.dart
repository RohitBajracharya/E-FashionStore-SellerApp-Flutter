// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var profileController = Get.find<ProfileController>();

  @override
  void initState() {
    profileController.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: white,
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            profileController.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      profileController.isLoading(true);
                      //if image is not selected
                      if (profileController.profileImagePath.value.isNotEmpty) {
                        await profileController.uploadProfileImage();
                      } else {
                        profileController.profileImageLink = profileController.snapshotData['imageUrl'];
                      }

                      //if old password matches database
                      if (profileController.snapshotData['password'] == profileController.oldpasswordController.text) {
                        await profileController.changeAuthPassword(
                          email: profileController.snapshotData['email'],
                          password: profileController.oldpasswordController.text,
                          newpassword: profileController.newpasswordController.text,
                        );
                        await profileController.updateProfile(
                          imgUrl: profileController.profileImageLink,
                          name: profileController.nameController.text,
                          password: profileController.newpasswordController.text,
                        );
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                        Get.to(() => const ProfileScreen());
                      } else if (profileController.oldpasswordController.text.isEmptyOrNull && profileController.newpasswordController.text.isEmptyOrNull) {
                        await profileController.updateProfile(
                          imgUrl: profileController.profileImageLink,
                          name: profileController.nameController.text,
                          password: profileController.snapshotData['password'],
                        );
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                        Get.to(() => const ProfileScreen());
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Some error occured");
                        profileController.isLoading(false);
                      }
                    },
                    child: normalText(
                      text: save,
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //user image
              profileController.snapshotData['imageUrl'] == '' && profileController.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 150,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : profileController.snapshotData['imageUrl'] != '' && profileController.profileImagePath.isEmpty
                      ? Image.network(
                          profileController.snapshotData['imageUrl'],
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(profileController.profileImagePath.value),
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  profileController.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(color: white),
              10.heightBox,
              customTextField(
                label: name,
                hint: "eg. Baba Devs",
                controller: profileController.nameController,
              ),
              30.heightBox,
              Align(alignment: Alignment.centerLeft, child: boldText(text: "Change your password")),
              20.heightBox,
              //new password field
              customTextField(
                label: password,
                hint: passwordHint,
                controller: profileController.oldpasswordController,
              ),
              10.heightBox,
              //password field
              customTextField(
                label: confirmPass,
                hint: passwordHint,
                controller: profileController.newpasswordController,
              ),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
