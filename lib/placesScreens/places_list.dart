import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/placesScreens/place_details.dart';
// import 'package:flutter_repo/models/place.dart';
import 'package:flutter_repo/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({super.key});
  @override
  ConsumerState<PlacesList> createState() {
    return _PlacesList();
  }
}

class _PlacesList extends ConsumerState<PlacesList> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _placesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final places = ref.watch(placesProvider);

        if (places.isEmpty) {
          return Center(child: DitchText(text: 'No places have been added yet'));
        }

        return ListView.builder(
          itemCount: places.length,
          itemBuilder: (ctx, index) => ListTile(
            leading: Hero(
              tag: places[index].id,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(places[index].image),
              ),
            ),
            title: DitchText(
              text: places[index].title,
              align: TextAlign.left,
            ),
            subtitle: DitchText(
              text: places[index].location.address,
              fontSize: 15,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetails(place: places[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}