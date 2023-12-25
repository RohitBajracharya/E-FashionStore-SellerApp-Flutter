import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/orders_screen/components/order_place.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "Order details", color: fontGrey, size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: ourButton(color: green, onPress: () {}, title: "Confirm Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order delivery status section
                Visibility(
                  //visible: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "Order Status:", color: fontGrey, size: 16.0),
                      SwitchListTile(
                        activeColor: green,
                        value: false,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: false,
                        onChanged: (value) {},
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: false,
                        onChanged: (value) {},
                        title: boldText(text: "on Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: false,
                        onChanged: (value) {},
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(8)).outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
                ),

                //order place details section
                Column(
                  children: [
                    orderPlaceDetailsSection(),
                    //shipping address and total amount section
                    shippingAddressNamountSection(),
                  ],
                ).box.outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
                const Divider(),
                10.heightBox,
                //ordered products
                orderedProductsSection(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  //ordered products
  Widget orderedProductsSection() {
    return Column(
      children: [
        boldText(text: "Orderd Products", color: fontGrey, size: 16.0),
        10.heightBox,
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(3, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderPlaceDetails(
                  title1: "data['orders'][index]['title']",
                  title2: "Rs. data['orders'][index]['total_price']}",
                  d1: "{data['orders'][index]['quantity']}*",
                  d2: "Refundable",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: 40,
                    height: 20,
                    color: purpleColor,
                  ),
                ),
                const Divider(),
              ],
            );
          }).toList(),
        ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
      ],
    );
  }

  //shipping address and total amount section
  Widget shippingAddressNamountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //"Shipping Address".text.fontFamily(semibold).make(),
              boldText(text: "Shipping Address", color: purpleColor),
              "{data['order_by_name']}".text.make(),
              "{data['order_by_email']}".text.make(),
              "{data['order_by_address']}".text.make(),
              "{data['order_by_city']}".text.make(),
              "{data['order_by_state']}".text.make(),
              "{data['order_by_phone']}".text.make(),
            ],
          ),
          SizedBox(
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(text: "Total Amount", color: purpleColor),
                boldText(text: "\$300.0", color: red, size: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //order place details section
  Widget orderPlaceDetailsSection() {
    return Column(
      children: [
        orderPlaceDetails(
          d1: "data['order_code']",
          d2: "data['shipping_method']",
          title1: "Order Code",
          title2: "Shipping Method",
        ),
        orderPlaceDetails(
          d1: DateTime.now(),
          // d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
          d2: "data['payment_method']",
          title1: "Order Date",
          title2: "Payment Method",
        ),
        orderPlaceDetails(
          d1: "Unpaid",
          d2: "Order Placed",
          title1: "Payment Status",
          title2: "Delivery Status",
        ),
      ],
    );
  }

  //order status section
  // Widget orderStatusSection() {
  //   return Column(
  //     children: [
  //       orderStatus(
  //         color: redColor,
  //         icon: Icons.done,
  //         title: "Placed",
  //         showDone: data['order_placed'],
  //       ),
  //       orderStatus(
  //         color: Colors.blue,
  //         icon: Icons.thumb_up,
  //         title: "Confirmed",
  //         showDone: data['order_confirmed'],
  //       ),
  //       orderStatus(
  //         color: Colors.yellow,
  //         icon: Icons.car_crash,
  //         title: "On Delivery",
  //         showDone: data['order_on_delivery'],
  //       ),
  //       orderStatus(
  //         color: Colors.purple,
  //         icon: Icons.done_all_rounded,
  //         title: "Delivered",
  //         showDone: data['order_delivered'],
  //       ),
  //     ],
  //   );,
  //       ),
  //     ),
  //   );
  // }
}
