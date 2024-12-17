import 'package:flutter/material.dart';

class SupplierReview extends StatefulWidget {
  final String searchQuery;

  const SupplierReview({super.key, required this.searchQuery});

  @override
  State<SupplierReview> createState() => _SupplierReviewState();
}

class _SupplierReviewState extends State<SupplierReview> {
  final List<Map<String, String>> supplierAccounts = [
    {"ID": "100", "Name": "Lina Enterprise", "Last Login": "21/10/2024 22:00"},
    {"ID": "101", "Name": "Pak Abu", "Last Login": "21/10/2024 22:00"},
  ];

  void deleteAccount(int index) {
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
            onPressed: () {
              setState(() {
                supplierAccounts.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deleted successfully!')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void viewDetails(Map<String, String> account) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Account Details: ${account["Name"]}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${account["ID"]}'),
            Text('Name: ${account["Name"]}'),
            Text('Last Login: ${account["Last Login"]}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredAccounts = supplierAccounts
        .where((account) =>
            account['Name']!.toLowerCase().contains(widget.searchQuery) ||
            account['ID']!.toLowerCase().contains(widget.searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredAccounts.length,
      itemBuilder: (context, index) {
        final account = filteredAccounts[index];
        return Card(
          child: ListTile(
            title: Text('${account["Name"]} (ID: ${account["ID"]})'),
            subtitle: Text('Last Login: ${account["Last Login"]}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteAccount(index),
            ),
            onTap: () => viewDetails(account),
          ),
        );
      },
    );
  }
}

