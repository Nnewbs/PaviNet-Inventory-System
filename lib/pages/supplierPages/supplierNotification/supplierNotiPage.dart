import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class SupplierNotiPage extends StatefulWidget {
  const SupplierNotiPage({super.key});

  @override
  State<SupplierNotiPage> createState() => _SupplierNotiPageState();
}

class _SupplierNotiPageState extends State<SupplierNotiPage> {
  // Sample notification data
  List<Map<String, dynamic>> notifications = [
    {
      'image': 'Cendol.jpg', 
      'name': 'Item 1',
      'quantity': 5,
      'message': 'Restock needed urgently.',
      'isRead': false
    },
    {
      'image': 'wantan.jpg',
      'name': 'Item 2',
      'quantity': 10,
      'message': 'Low stock alert.',
      'isRead': false
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Notification',
            style: CustomeTextStyle.txtWhiteBold,
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: notification['isRead'] ? Colors.grey[300] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Image.asset(notification['image'], width: 50, height: 50),
                title: Text(notification['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quantity: ${notification['quantity']}'),
                    Text(notification['message']),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.mark_email_read, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      notifications[index]['isRead'] = true;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

              
