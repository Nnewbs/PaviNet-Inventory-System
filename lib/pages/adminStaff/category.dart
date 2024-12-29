import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

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

  // Sample data with categories
  final List<Map<String, String>> items = [
    {
      "title": "Choco Moist",
      "owner": "Lina Enterprise",
      "price": "RM 6.50",
      "category": "Bakery",
    },
    {
      "title": "Cendol",
      "owner": "Pak Abu",
      "price": "RM 5.50",
      "category": "Fresh",
    },
    {
      "title": "Wantan",
      "owner": "Lina Enterprise",
      "price": "RM 5.50",
      "category": "Prepared",
    },
    {
      "title": "Tart",
      "owner": "Lina Enterprise",
      "price": "RM 7.50",
      "category": "Bakery",
    },
  ];

  // Filtered list based on category and search query
  List<Map<String, String>> get filteredItems {
    return items.where((item) {
      final matchesCategory = selectedCategory == "All Category" ||
          item["category"] == selectedCategory;

      final matchesSearch = searchQuery.isEmpty ||
          item["title"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["owner"]!.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
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
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        "No items found",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : GridView.builder(
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
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bigger Image Placeholder
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300], // Placeholder color
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.image,
                                      color: Colors.grey[600], size: 40),
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
                                      item["title"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item["owner"]!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item["price"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
