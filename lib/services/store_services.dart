import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore.collection(vendorsCollection).where('id', isEqualTo: uid).get();
  }

  static getMessages(uid) {
    return firestore.collection(chatsCollection).where('toId', isEqualTo: uid).snapshots();
  }

  //get all chat messages
  static getChatMessages(docId) {
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
  }

  //get all orders
  static getOrders(uid) {
    return firestore.collection(ordersCollection).where('vendors', arrayContains: uid).snapshots();
  }

   static Future<int> countOrders(String vendorId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ordersCollection').where('vendors', arrayContains: vendorId).get();
    return querySnapshot.size;
  }

  //get all products
  static getProducts(uid) {
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
  }
}
