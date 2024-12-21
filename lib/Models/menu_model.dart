import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  final String name;
  final String description;
  final String price;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
  });

  factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
      name: data['name'],
      description: data['description'],
      price: data['price'],
    );
  }
}

class MenuDay {
  final String day;
  final List<MenuItem> items;

  MenuDay({
    required this.day,
    required this.items,
  });

  factory MenuDay.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final items = (data['items'] as List<dynamic>)
        .map((item) => MenuItem.fromMap(item as Map<String, dynamic>))
        .toList();
    return MenuDay(
      day: data['day'],
      items: items,
    );
  }
}

class MenuService {
  final CollectionReference menus =
      FirebaseFirestore.instance.collection('menus');

  Future<List<MenuDay>> fetchMenuData() async {
    final snapshot = await menus.get();
    return snapshot.docs.map((doc) => MenuDay.fromDocument(doc)).toList();
  }
}

