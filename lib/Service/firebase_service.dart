import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference orderRequestCollection =
      FirebaseFirestore.instance.collection('orderReq');

  /// Adds a new order request to the Firestore `orderReq` collection with a specific document ID.
  ///
  /// [docId] specifies the document ID to use.
  Future<void> createOrderRequest({
    required String supplierName,
    required String phoneNumber,
    required String itemName,
    required String category,
    required int requestedQuantity,
    required String unitType,
    String? notes,
    String? docId, // Optional custom document ID
  }) async {
    try {
      // Create the order data map
      Map<String, dynamic> orderData = {
        'supplierName': supplierName,
        'phoneNumber': phoneNumber,
        'itemName': itemName,
        'category': category,
        'requestedQuantity': requestedQuantity,
        'unitType': unitType,
        'notes': notes ?? '',
        'createdAt': Timestamp.now(),
      };

      // If a document ID is provided, use the `set` method
      if (docId != null && docId.isNotEmpty) {
        await orderRequestCollection.doc(docId).set(orderData);
      } else {
        // Otherwise, use the `add` method to generate an automatic document ID
        await orderRequestCollection.add(orderData);
      }
    } catch (e) {
      throw Exception('Failed to create order request: $e');
    }
  }
}
