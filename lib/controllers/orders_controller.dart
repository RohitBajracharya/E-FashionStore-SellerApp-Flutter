import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_consts.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  var ordersCount = 0.obs;

  void countOrders(String vendorId) {
    StoreServices.countOrders(vendorId).then((count) {
      ordersCount.value = count;
    }).catchError((error) {
      // Handle errors if necessary
      print('Error counting orders: $error');
    });
  }

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeOrderStatus({title, status, docId}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
