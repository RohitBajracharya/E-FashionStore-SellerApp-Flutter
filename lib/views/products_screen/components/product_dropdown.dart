import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

Widget productDropdown() {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      hint: normalText(text: "Choose category", color: fontGrey),
      value: null,
      isExpanded: true,
      items: const [],
      onChanged: (value) {},
    ),
  ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make();
}
