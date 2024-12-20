import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hugeicons/hugeicons.dart';

class FetchDataExample extends StatefulWidget {
  @override
  _FetchDataExampleState createState() => _FetchDataExampleState();
}

class _FetchDataExampleState extends State<FetchDataExample>
    with SingleTickerProviderStateMixin {
  final CollectionReference menus =
      FirebaseFirestore.instance.collection('menus');
  late TabController tabController;

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: days.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Menu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100), // Adjust the height
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search you meals..",
                    prefixIcon: HugeIcon(
                        icon: HugeIcons.strokeRoundedSearch01,
                        color: Colors.orange),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2.0), // Change the color and width here
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              // Tabs
              TabBar(
                labelColor: Colors.orange,
                indicatorColor: Colors.orange,
                controller: tabController,
                isScrollable: true,
                tabs: days.map((day) => Tab(text: day)).toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: days.map((day) {
          return FutureBuilder(
            future: menus.where('day', isEqualTo: day).get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Menu Found for $day"));
              }

              // Filter menu items by search query
              final List<dynamic> items = snapshot.data!.docs
                  .expand(
                      (doc) => (doc.data() as Map<String, dynamic>)['items'])
                  .where((item) =>
                      (item['name'] as String)
                          .toLowerCase()
                          .contains(searchQuery) ||
                      (item['description'] as String)
                          .toLowerCase()
                          .contains(searchQuery))
                  .toList();

              if (items.isEmpty) {
                return Center(child: Text("No items match your search query."));
              }

              return GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2 // 2 cards per row in portrait mode
                        : 3, // 3 cards per row in landscape mode
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                padding: EdgeInsets.all(8),
                children: List.generate(items.length, (index) {
                  Map<String, dynamic> item = items[index];
                  return Card(
                    color: Colors.blueGrey.shade100,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image Section
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/imagetest.png", // Replace with your image path
                              width: double.infinity,
                              height: 100, // Adjust height to fit the layout
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Text Section
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Price: \$${item['price']}",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                        // Quantity Section
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(
                              bottom: 8), // Adds some spacing at the bottom
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Minus Button
                              GestureDetector(
                                onTap: () {
                                  // Handle decrement
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: HugeIcon(
                                      icon: HugeIcons.strokeRoundedMinusSign,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              // Quantity
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // Plus Button
                              GestureDetector(
                                onTap: () {
                                  // Handle increment
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: HugeIcon(
                                      icon: HugeIcons.strokeRoundedAdd01,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
