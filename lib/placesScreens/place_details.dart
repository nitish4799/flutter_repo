import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/place.dart';
import 'package:flutter_repo/placesScreens/map.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=AIzaSyAB3JHabOUCA666q2NWnhXVDqmenRs9b50';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DitchText(text: place.title)),
      body: Stack(
        children: [
          Hero(
            tag: place.id,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (ctx) => MapScreen(
                              location: place.location,
                              isSelecting: false,
                            ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: DitchText(text: place.location.address, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
