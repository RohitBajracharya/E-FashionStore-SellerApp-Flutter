import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: white,
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            profileController.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      profileController.isLoading(true);
                      await profileController.updateShop(
                        shopname: profileController.shopNameControllers.text,
                        shopaddress: profileController.shopAddressControllers.text,
                        shopmobile: profileController.shopMobileControllers.text,
                        shopwebsite: profileController.shopWebsiteControllers.text,
                        shopdescription: profileController.shopDescriptionControllers.text,
                      );
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Shop updated");
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
              customTextField(
                label: shopName,
                hint: nameHint,
                controller: profileController.shopNameControllers,
              ),
              10.heightBox,
              customTextField(
                label: address,
                hint: shopAddressHint,
                controller: profileController.shopAddressControllers,
              ),
              10.heightBox,
              customTextField(
                label: mobile,
                hint: shopMobileHint,
                controller: profileController.shopMobileControllers,
              ),
              10.heightBox,
              customTextField(
                label: website,
                hint: shopWebsiteHint,
                controller: profileController.shopWebsiteControllers,
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                label: description,
                hint: shopDescHint,
                controller: profileController.shopDescriptionControllers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
