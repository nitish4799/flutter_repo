import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_repo/ditch_elevated_button.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/ditch_text_button.dart';
import 'package:flutter_repo/shoppingData/category.dart';
import 'package:flutter_repo/shoppingModels/category.dart';
import 'package:flutter_repo/shoppingModels/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<NewItem> createState() {
    return _NewItem();
  }
}

class _NewItem extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _enteredCategory = categories[Categories.vegetables]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
        'flutter-prep-9ca30-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );
      final postResponse = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _enteredCategory.title,
        }),
      );
      final Map<String, dynamic> item = json.decode(postResponse.body);
      // print(bete['name']);
      if (!context.mounted) {
        return;
      }
      // Navigator.of(context).pop({item});
      Navigator.of(context).pop(
        GroceryItem(
          id: item['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _enteredCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DitchText(text: 'Add a new item.'),
        backgroundColor: const Color.fromARGB(255, 55, 54, 54),
      ),
      backgroundColor: Color.fromARGB(255, 80, 76, 76),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(label: DitchText(text: 'Name')),
                validator: (val) {
                  if (val == null ||
                      val.isEmpty ||
                      val.length <= 1 ||
                      val.length > 50) {
                    return 'Name should be 1 to 50 chars.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: DitchText(text: 'Quantity'),
                      ),
                      initialValue: _enteredQuantity.toString(),
                      validator:
                          (value) =>
                              (value == null ||
                                          value.isEmpty ||
                                          int.tryParse(value) == null) ||
                                      int.tryParse(value)! <= 0
                                  ? 'Quantity must be positive'
                                  : null,
                      onSaved:
                          (newValue) => _enteredQuantity = int.parse(newValue!),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _enteredCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                SizedBox(width: 6),
                                DitchText(text: category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _enteredCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DitchTextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    label: 'Reset',
                  ),
                  DitchElevatedButton(
                    onClickHandler: _saveItem,
                    label: 'Add Item',
                    buttonWidth: 200,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
