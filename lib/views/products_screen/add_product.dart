import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: boldText(text: "Add product", size: 16.0),
        actions: [TextButton(onPressed: () {}, child: boldText(text: save, color: white))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                hint: "eg. BMW",
                label: "Product name",
              ),
              10.heightBox,
              customTextField(
                hint: "eg. Nice product",
                label: "Description",
                isDesc: true,
              ),
              10.heightBox,
              customTextField(
                hint: "eg. \$100",
                label: "Price",
              ),
              10.heightBox,
              customTextField(
                hint: "eg. 20",
                label: "Quantity",
              ),
              10.heightBox,
              productDropdown(),
              10.heightBox,
              productDropdown(),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose product images"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) => productImages(label: "${index + 1}"),
                ),
              ),
              5.heightBox,
              normalText(text: "First image will be your display image", color: lightGrey),
              const Divider(
                color: white,
              ),
              10.heightBox,
              boldText(text: "Choose product colors"),
              10.heightBox,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                    9,
                    (index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50, 50).make(),
                            const Icon(
                              Icons.done,
                              color: white,
                            ),
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
