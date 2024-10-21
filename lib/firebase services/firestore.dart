import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coffee.dart';

class FirestoreService {
  final String userId;
  final CollectionReference cartCollection;

  FirestoreService(this.userId)
      : cartCollection = FirebaseFirestore.instance
            .collection("user")
            .doc(userId)
            .collection("cartCollection");

  Future<void> addItemToCart(Coffee coffee) async {
    await cartCollection.add(coffee.toMap());
  }

  Stream<List<Coffee>> getCartItems() {
    return cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Coffee.fromMap(doc.data() as Map<String, dynamic>)
          ..id = doc.id; // Store document ID for deletion
      }).toList();
    });
  }

  Future<void> deleteItemFromCart(String itemId) async {
    await cartCollection.doc(itemId).delete();
  }

  Future<void> clearCart() async {
    final snapshot = await cartCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
