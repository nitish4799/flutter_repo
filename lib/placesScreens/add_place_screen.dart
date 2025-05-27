import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/place.dart';
import 'package:flutter_repo/placesScreens/image_input.dart';
import 'package:flutter_repo/placesScreens/location_input.dart';
import 'package:flutter_repo/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void savePlace() {
    final enteredItem = _titleController.text;
    if (enteredItem.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(placesProvider.notifier)
        .addPlace(enteredItem, _selectedImage!, _selectedLocation!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DitchText(text: 'Add a new place')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            ImageInput(
              onPickImage: (File img) {
                _selectedImage = img;
              },
            ),
            SizedBox(height: 12),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: Icon(Icons.add),
              label: DitchText(text: 'Add Place', fontSize: 18),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 57, 55, 55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
