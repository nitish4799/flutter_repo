import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
// import 'package:flutter_repo/models/place.dart';
import 'package:flutter_repo/placesScreens/add_place_screen.dart';
import 'package:flutter_repo/placesScreens/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final places = ref.watch(context).noti
    return Scaffold(
      appBar: AppBar(
        title: DitchText(text: 'Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => AddPlaceScreen()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      // body: PlacesList(places: [Place(title: 'New York')]),
      body: PlacesList(),
    );
  }
}
