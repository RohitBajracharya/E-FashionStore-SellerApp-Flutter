import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: hint, color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(value: e, child: e.toString().text.make());
        }).toList(),
        onChanged: (newvalue) {
          if (hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubcategoryList(newvalue.toString());
          }
          dropvalue.value = newvalue.toString();
        },
      ),
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}
