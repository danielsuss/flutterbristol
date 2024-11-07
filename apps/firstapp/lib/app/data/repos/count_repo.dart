import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CountRepo extends GetxService {

  @override
  void onInit() {
    super.onInit();
    // if document counters/count does not exist, create it
    FirebaseFirestore.instance.collection('counters').doc('count').get().then((doc) {
      if (!doc.exists) {
        FirebaseFirestore.instance.collection('counters').doc('count').set({'count': 0});
      }
    });
  }

  Stream<int> subscribeToCount() {
    return FirebaseFirestore.instance.collection('counters').doc('count').snapshots().map((doc) => doc.data()!['count']);
  }

  Future<void> incrementCount() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final doc = await transaction.get(FirebaseFirestore.instance.collection('counters').doc('count'));
      final count = doc.data()!['count'] + 1;
      transaction.update(FirebaseFirestore.instance.collection('counters').doc('count'), {'count': count});
    });
  }

  Future<void> decrementCount() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final doc = await transaction.get(FirebaseFirestore.instance.collection('counters').doc('count'));
      final count = doc.data()!['count'] - 1;
      transaction.update(FirebaseFirestore.instance.collection('counters').doc('count'), {'count': count});
    });
  }

  Future<void> resetCount() async {
    await FirebaseFirestore.instance.collection('counters').doc('count').update({'count': 0});
  }

  Future<void> setCount(int count) async {
    await FirebaseFirestore.instance.collection('counters').doc('count').update({'count': count});
  }

  @override
  void onClose() {
    super.onClose();
  }


  
}
 