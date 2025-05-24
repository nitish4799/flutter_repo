import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/shoppingData/category.dart';
// import 'package:flutter_repo/shoppingModels/category.dart';
// import 'package:flutter_repo/shoppingData/dummy_items.dart';
import 'package:flutter_repo/shoppingModels/grocery_item.dart';
import 'package:flutter_repo/shoppingScreens/new_item.dart';
import 'package:http/http.dart' as http;

class ShoppingHome extends StatefulWidget {
  const ShoppingHome({super.key});

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  List<GroceryItem> items = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() async {
    final url = Uri.https(
      'flutter-prep-9ca30-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> popList = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in popList.entries) {
      final category = categories.entries.firstWhere(
        (e) => e.value.title == item.value['category'],
      );
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value,
        ),
      );
    }
    setState(() {
      items = loadedItems;
      isLoading = false;
    });
    // print(items);
  }

  void addItemScreen() async {
    // final popList = await
    final item = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (item == null) return;
    setState(() {
      items.add(item);
    });
    // if (popList == null) {
    //   return;
    // }
    // loadItems();
    // setState(() {
    //   items.add(popList);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DitchText(text: 'Your Groceries'),
        backgroundColor: const Color.fromARGB(255, 55, 54, 54),
        actions: [IconButton(onPressed: addItemScreen, icon: Icon(Icons.add))],
      ),
      backgroundColor: Color.fromARGB(255, 80, 76, 76),
      body:
          isLoading
              ? Center(child: CupertinoActivityIndicator(radius: 12.0))
              : items.isNotEmpty
              ? ListView.builder(
                // itemCount: groceryItems.length,
                itemCount: items.length,
                itemBuilder:
                    (ctx, index) => ListTile(
                      title: DitchText(
                        text: items[index].name,
                        align: TextAlign.left,
                      ),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: items[index].category.color,
                      ),
                      trailing: DitchText(
                        text: items[index].quantity.toString(),
                      ),
                    ),
              )
              : Center(child: DitchText(text: 'add karle bhai isme kuch ')),
    );
  }
}
