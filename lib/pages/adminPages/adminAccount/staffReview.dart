import 'package:flutter/material.dart';

class StaffReview extends StatefulWidget {
  final String searchQuery;

  const StaffReview({super.key, required this.searchQuery});

  @override
  State<StaffReview> createState() => _StaffReviewState();
}

class _StaffReviewState extends State<StaffReview> {
  final List<Map<String, String>> staffAccounts = [
    {"ID": "01", "Name": "Emmy", "Last Login": "21/10/2024 22:00"},
    {"ID": "02", "Name": "Myra", "Last Login": "21/10/2024 22:00"},
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
                staffAccounts.removeAt(index);
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
    final filteredAccounts = staffAccounts
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
