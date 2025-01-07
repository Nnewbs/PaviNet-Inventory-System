import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference supplierOrdersCollection =
      FirebaseFirestore.instance.collection('supplierOrders');

  /// Adds a new order request to the Firestore `supplierOrders` collection with a specific document ID.
  ///
  /// [docId] specifies the document ID to use.
  Future<void> createOrderRequest({
    required String supplierName,
    required String itemName,
    required String category,
    required int requestedQuantity,
    String? notes,
    String? docId, // Optional custom document ID
  }) async {
    try {
      // Create the order data map
      Map<String, dynamic> orderData = {
        'supplierName': supplierName,
        'itemName': itemName,
        'category': category,
        'requestedQuantity': requestedQuantity,
        'notes': notes ?? '',
        'status': 'Pending', // Default status
        'createdAt': Timestamp.now(),
      };

      // If a document ID is provided, use the `set` method
      if (docId != null && docId.isNotEmpty) {
        await supplierOrdersCollection.doc(docId).set(orderData);
      } else {
        // Otherwise, use the `add` method to generate an automatic document ID
        await supplierOrdersCollection.add(orderData);
      }
    } catch (e) {
      throw Exception('Failed to create order request: $e');
    }
  }

  /// Retrieves all order requests for a specific user from the `supplierOrders` collection.
  Stream<QuerySnapshot> getOrderRequests({required String userId}) {
    return supplierOrdersCollection
        .where('userId', isEqualTo: userId) // Filter by userId
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
