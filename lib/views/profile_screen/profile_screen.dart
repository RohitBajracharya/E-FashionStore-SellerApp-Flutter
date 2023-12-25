import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/messages_screen/messages_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_profilescreen.dart';
import 'package:emart_seller/views/shop_screen/shop_settings_screen.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const EditProfileScreen());
              },
              icon: const Icon(
                Icons.edit,
                color: white,
              )),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signout(context);
              Get.offAll(() => const LoginScreen());
            },
            child: normalText(text: logout),
          ),
        ],
      ),
      body: Column(children: [
        ListTile(
          leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
          title: boldText(text: "Vendor name"),
          subtitle: normalText(text: "Vendoremail@emart.com"),
        ),
        const Divider(),
        10.heightBox,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(
                profileButtonsIcons.length,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const ShopSettings());
                            break;
                          case 1:
                            Get.to(() => const MessagesScreen());
                          default:
                        }
                      },
                      leading: Icon(
                        profileButtonsIcons[index],
                        color: white,
                      ),
                      title: normalText(text: profileButtonsTitles[index]),
                    )),
          ),
        )
      ]),
    );
  }
}
