import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/add_product.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await productController.getCategories();
          productController.populateCategoryList();
          Get.to(() => const AddProduct());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetails(data: data[index]));
                                },
                                leading: Image.network(
                                  data[index]['p_images'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    normalText(text: "Rs. ${data[index]['p_price']}", color: darkGrey),
                                    10.widthBox,
                                    boldText(text: data[index]['is_featured'] == true ? "Featured" : '', color: green),
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                  arrowSize: 0.0,
                                  menuBuilder: () => Column(
                                    children: List.generate(
                                      popupMenuIcons.length,
                                      (index) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(popupMenuIcons[index]),
                                              10.widthBox,
                                              normalText(
                                                text: popupMenuTitles[index],
                                                color: darkGrey,
                                              )
                                            ],
                                          ).onTap(() {})),
                                    ),
                                  ).box.white.rounded.width(200).make(),
                                  clickType: VxClickType.singleClick,
                                  child: const Icon(Icons.more_vert_rounded),
                                ),
                              ),
                            ))),
              ),
            );
          }
        },
      ),
    );
  }
}
