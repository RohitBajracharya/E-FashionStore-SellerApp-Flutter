import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/dashboard_button.dart';
import 'package:emart_seller/views/widgets/text_style.dart';

import '../../const/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              dashboardButton(context,
                  title: products, count: "60", icon: icProducts),
              dashboardButton(context,
                  title: orders, count: "15", icon: icOrders),
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              dashboardButton(context,
                  title: rating, count: "60", icon: icStar),
              dashboardButton(context,
                  title: totalSales, count: "15", icon: icOrders),
            ],
          ),
          10.heightBox,
          const Divider(),
          10.heightBox,
          boldText(text: popular, color: fontGrey, size: 16.0),
          20.heightBox,
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  8,
                  (index) => ListTile(
                        onTap: () {},
                        leading: Image.asset(imgProduct,
                            width: 100, height: 100, fit: BoxFit.cover),
                        title: boldText(text: "Product title", color: fontGrey),
                        subtitle: normalText(text: "\$40.0", color: darkGrey),
                      )),
            ),
          )
        ]),
      ),
    );
  }
}
