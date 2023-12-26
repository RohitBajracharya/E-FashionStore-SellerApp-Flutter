// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/views/orders_screen/components/order_place.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var orderController = Get.put(OrdersController());
  @override
  void initState() {
    super.initState();
    orderController.getOrders(widget.data);
    orderController.confirmed.value = widget.data['order_confirmed'];
    orderController.onDelivery.value = widget.data['order_on_delivery'];
    orderController.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
        bottomNavigationBar: Visibility(
          visible: !orderController.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                color: green,
                onPress: () {
                  orderController.confirmed(true);
                  orderController.changeOrderStatus(
                    title: "order_confirmed",
                    status: true,
                    docId: widget.data.id,
                  );
                },
                title: "Confirm Order"),
          ),
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
                    visible: orderController.confirmed.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText(text: "Order Status:", color: fontGrey, size: 16.0),
                        SwitchListTile(
                          activeColor: green,
                          value: true,
                          onChanged: (value) {},
                          title: boldText(text: "Placed", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: orderController.confirmed.value,
                          onChanged: (value) {
                            orderController.confirmed.value = value;
                          },
                          title: boldText(text: "Confirmed", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: orderController.onDelivery.value,
                          onChanged: (value) {
                            orderController.onDelivery.value = value;
                            orderController.changeOrderStatus(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id,
                            );
                          },
                          title: boldText(text: "on Delivery", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: orderController.delivered.value,
                          onChanged: (value) {
                            orderController.delivered.value = value;
                            orderController.changeOrderStatus(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id,
                            );
                          },
                          title: boldText(text: "Delivered", color: fontGrey),
                        ),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
                  ),

                  //order place details section
                  Column(
                    children: [
                      orderPlaceDetailsSection(widget.data),
                      //shipping address and total amount section
                      shippingAddressNamountSection(widget.data),
                    ],
                  ).box.outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
                  const Divider(),
                  10.heightBox,
                  //ordered products
                  orderedProductsSection(widget.data),
                  20.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //ordered products
  Widget orderedProductsSection(data) {
    return Column(
      children: [
        boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
        10.heightBox,
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(orderController.orders.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderPlaceDetails(
                  title1: "${orderController.orders[index]['title']}",
                  title2: "Rs. ${orderController.orders[index]['total_price']}",
                  d1: "${orderController.orders[index]['quantity']}x",
                  d2: "Refundable",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: 40,
                    height: 20,
                    color: Color(orderController.orders[index]['color']),
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
  Widget shippingAddressNamountSection(data) {
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
              "${data['order_by_name']}".text.make(),
              "${data['order_by_email']}".text.make(),
              "${data['order_by_address']}".text.make(),
              "${data['order_by_city']}".text.make(),
              "${data['order_by_state']}".text.make(),
              "${data['order_by_phone']}".text.make(),
            ],
          ),
          SizedBox(
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(text: "Total Amount", color: purpleColor),
                boldText(text: "\$${data['total_amount']}", color: red, size: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //order place details section
  Widget orderPlaceDetailsSection(data) {
    return Column(
      children: [
        orderPlaceDetails(
          d1: "${data['order_code']}",
          d2: "${data['shipping_method']}",
          title1: "Order Code",
          title2: "Shipping Method",
        ),
        orderPlaceDetails(
          // d1: DateTime.now(),
          d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
          d2: "${data['payment_method']}",
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
}
