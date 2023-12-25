import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 80,
                  ).box.border(color: white).rounded.padding(const EdgeInsets.all(8)).make(),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: appname, size: 20.0),
                      boldText(text: appTypes, size: 14.0),
                    ],
                  ),
                ],
              ),
              40.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              10.heightBox,
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textFieldGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint),
                  ),
                  10.heightBox,
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: textFieldGrey,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint),
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: normalText(text: forgotPassword, color: purpleColor)),
                  ),
                  20.heightBox,
                  SizedBox(
                    width: context.screenWidth - 100,
                    child: ourButton(
                      title: login,
                      onPress: () {
                        Get.to(() => const Home());
                      },
                    ),
                  )
                ],
              ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(
                child: boldText(text: credit),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
