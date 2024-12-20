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
                    
                    prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01, color: Colors.orange),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange, width: 2.0), // Change the color and width here
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
                  .expand((doc) => (doc.data() as Map<String, dynamic>)['items'])
                  .where((item) =>
                      (item['name'] as String).toLowerCase().contains(searchQuery) ||
                      (item['description'] as String)
                          .toLowerCase()
                          .contains(searchQuery))
                  .toList();

              if (items.isEmpty) {
                return Center(child: Text("No items match your search query."));
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = items[index];
                  return Card(
                    color: Colors.blueGrey.shade100,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    // child: ListTile(
                    //   title: Text(
                    //     item['name'],
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    //   subtitle: Text(item['description']),
                    //   trailing: Text(
                    //     "Price: ${item['price']}",
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                      child: Row(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(8),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     shape: BoxShape.circle
                          //   ),
                          //   child: CircleAvatar(
                          //     radius: 45,
                          //     backgroundImage: AssetImage("assets/imagetest.png"),
                          //   ),
                          // ),
                          
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                              Text(
                                "Price: ${item['price']}",
                                style: TextStyle(color: Colors.black),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
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