// ignore_for_file: depend_on_referenced_packages

import 'package:emart_seller/views/orders_screen/order_details.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/const.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: List.generate(
            20,
            (index) => ListTile(
              onTap: () {
                Get.to(() => const OrderDetails());
              },
              tileColor: textFieldGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: boldText(text: "222345567", color: purpleColor),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: fontGrey,
                      ),
                      10.widthBox,
                      boldText(text: intl.DateFormat().add_yMd().format(DateTime.now()), color: fontGrey),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.payment,
                        color: fontGrey,
                      ),
                      10.widthBox,
                      boldText(text: unpaid, color: red),
                    ],
                  )
                ],
              ),
              trailing: boldText(text: "\$40.0", color: purpleColor, size: 16.0),
            ).box.margin(const EdgeInsets.only(bottom: 4)).make(),
          )),
        ),
      ),
    );
  }
}
