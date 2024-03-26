// ignore_for_file: use_build_context_synchronously

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
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
          actions: [
            productController.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      productController.isloading(true);
                      await productController.uploadImages();
                      await productController.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save, color: white),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  hint: "eg. Jeans T-Shirts",
                  label: "Product name",
                  controller: productController.pNameController,
                ),
                10.heightBox,
                customTextField(
                  hint: "eg. Blue Jeans tshirt",
                  label: "Description",
                  isDesc: true,
                  controller: productController.pDescriptionController,
                ),
                10.heightBox,
                customTextField(
                  hint: "eg. Rs 100",
                  label: "Price",
                  controller: productController.pPriceController,
                ),
                10.heightBox,
                customTextField(
                  hint: "eg. 20",
                  label: "Quantity",
                  controller: productController.pQuantityController,
                ),
                10.heightBox,
                productDropdown(
                  "Category",
                  productController.categoryList,
                  productController.categoryvalue,
                  productController,
                ),
                10.heightBox,
                productDropdown(
                  "SubCategory",
                  productController.subCategoryList,
                  productController.subcategoryvalue,
                  productController,
                ),
                10.heightBox,
                const Divider(color: white),
                boldText(text: "Choose product images"),
                10.heightBox,
                //image
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => productController.pImagesList[index] != null
                          ? Image.file(
                              productController.pImagesList[index],
                              width: 100,
                              height: 100,
                            ).onTap(() {
                              productController.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              productController.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(text: "First image will be your display image", color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                //product color
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      productController.productColors.length,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox().color(Color(productController.productColors[index])).roundedFull.size(65, 65).make().onTap(() {
                            bool isSelected = productController.selectedColorIndex.contains(index);
                            if (isSelected) {
                              productController.selectedColorIndex.remove(index);
                            } else {
                              productController.selectedColorIndex.add(index);
                            }
                          }),
                          productController.selectedColorIndex.contains(index) ? const Icon(Icons.done, color: white) : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
