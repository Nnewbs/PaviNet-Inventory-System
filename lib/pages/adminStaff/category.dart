import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavinet/pages/adminStaff/updateDetails.dart';
import 'package:pavinet/pages/chat.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // List of categories
  final List<String> categories = [
    "All Category",
    "Bakery",
    "Prepared",
    "Fresh"
  ];
  String selectedCategory = "All Category";

  // Search input
  String searchQuery = "";

  // Fetch data from Firestore
  Future<List<Map<String, dynamic>>> fetchItems() async {
    final snapshot = await FirebaseFirestore.instance.collection('items').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id, // Keep track of the document ID
        "title": data["title"] ?? "",
        "owner": data["owner"] ?? "",
        "price": data["price"] ?? "",
        "category": data["category"] ?? "",
        "quantity": data["quantity"] ?? 0,
        "imagePath":
            data["imagePath"] ?? "default_image.png", // Default if no image
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Category', style: CustomeTextStyle.txtWhiteBold),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search by title or owner",
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Category Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedCategory == category
                            ? Colors.orange
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Food Items Grid
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error fetching data"),
                    );
                  }
                  final filteredItems = snapshot.data!.where((item) {
                    final matchesCategory =
                        selectedCategory == "All Category" ||
                            item["category"] == selectedCategory;

                    final matchesSearch = searchQuery.isEmpty ||
                        item["title"]!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        item["owner"]!
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());

                    return matchesCategory && matchesSearch;
                  }).toList();

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      // Assuming each item has an 'imagePath' field that stores the image filename
                      final imagePath = item["imagePath"] ??
                          "default_image.png"; // Default image if not found
                      final quantity =
                          item["quantity"] ?? 0; // Default quantity

                      return InkWell(
                        onTap: () {
                          debugPrint('redirect to update/delete page');
                          // push to test
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Chat()));
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display Image from assets
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/$imagePath', // Dynamic path
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ), // Fallback icon
                                    );
                                  },
                                ),
                              ),
                              // Food Details
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"] ??
                                          "No Title", // Default value if title is null
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item["owner"] ??
                                          "No Owner", // Default value if owner is null
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 68, 22, 22),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'RM${item["price"].toStringAsFixed(2)}' ??
                                              "No Price", // Default value if price is null
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        // Display the stock number inside a small box
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
