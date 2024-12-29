import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StaffReview extends StatefulWidget {
  final String searchQuery;

  const StaffReview({super.key, required this.searchQuery});

  @override
  State<StaffReview> createState() => _StaffReviewState();
}

class _StaffReviewState extends State<StaffReview> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void deleteAccount(String docId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firestore.collection('users').doc(docId).delete();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Account deleted successfully!')),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('role', isEqualTo: 'User')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final accounts = snapshot.data!.docs.where((doc) {
          final name = doc['name'].toLowerCase();
          final id = doc.id.toLowerCase();
          return name.contains(widget.searchQuery) ||
              id.contains(widget.searchQuery);
        }).toList();

        return ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];

            // Safely retrieve document data
            final data = account.data() as Map<String, dynamic>?;

            // Check if the 'lastLogin' field exists and fetch its value
            final Timestamp? lastLogin =
                (data != null && data.containsKey('lastLogin'))
                    ? data['lastLogin'] as Timestamp?
                    : null;

            // Convert the Timestamp to a readable string or set to 'Never' if null
            final String lastLoginString =
                lastLogin != null ? lastLogin.toDate().toString() : 'Never';

            return Card(
              child: ListTile(
                title: Text('${data?['name']} (ID: ${account.id})'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${data?['email']}'),
                    Text('Last Login: $lastLoginString'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteAccount(account.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
