import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());

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
              //app logo and name
              appDescription(),
              40.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              10.heightBox,
              // form
              Obx(
                () => Column(
                  children: [
                    //email field
                    emailFormField(authController),
                    10.heightBox,
                    //password
                    passwordFormField(authController),
                    10.heightBox,
                    //forget password button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: normalText(text: forgotPassword, color: purpleColor),
                      ),
                    ),
                    20.heightBox,
                    //login button
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: authController.isLoading.value
                          ? Center(child: loadingIndicator())
                          : ourButton(
                              title: login,
                              onPress: () async {
                                authController.isLoading(true);
                                await authController.login(context: context).then(
                                  (value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged In");
                                      authController.isLoading(false);
                                      Get.to(() => const Home());
                                    } else {
                                      authController.isLoading(false);
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(16)).make(),
              ),
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

  TextFormField passwordFormField(AuthController authController) {
    return TextFormField(
      obscureText: true,
      controller: authController.passwordController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: textFieldGrey,
        prefixIcon: Icon(
          Icons.lock,
          color: purpleColor,
        ),
        border: InputBorder.none,
        hintText: passwordHint,
      ),
    );
  }

  TextFormField emailFormField(AuthController authController) {
    return TextFormField(
      controller: authController.emailController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: textFieldGrey,
        prefixIcon: Icon(
          Icons.email,
          color: purpleColor,
        ),
        border: InputBorder.none,
        hintText: emailHint,
      ),
    );
  }

  Row appDescription() {
    return Row(
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
    );
  }
}
