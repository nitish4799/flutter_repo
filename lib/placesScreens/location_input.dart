import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/place.dart';
import 'package:flutter_repo/placesScreens/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

// AIzaSyAB3JHabOUCA666q2NWnhXVDqmenRs9b50

class _LocationInput extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) return '';
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=AIzaSyAB3JHabOUCA666q2NWnhXVDqmenRs9b50';
  }

  Future<void> savePlace(double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAB3JHabOUCA666q2NWnhXVDqmenRs9b50',
    );
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    setState(() {
      _pickedLocation = PlaceLocation(
        address: address,
        latitude: lat,
        longitude: lng,
      );
      _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
  }

  void _getUserLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    final lng = locationData.longitude;
    final lat = locationData.latitude;
    if (lat == null || lng == null) return;
    savePlace(lat, lng);
  }

  void selectOnMap() async {
    final pickedLocation = await Navigator.of(
      context,
    ).push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen()));

    if (pickedLocation == null) {
      return;
    }
    savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity * 0.8,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child:
                _isGettingLocation == true
                    ? CircularProgressIndicator()
                    : _pickedLocation != null
                    ? Image.network(
                      locationImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                    : DitchText(text: 'No location choosen'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: _getUserLocation,
              label: DitchText(text: 'Get Current Location', fontSize: 15),
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              onPressed: selectOnMap,
              label: DitchText(text: 'Select on map', fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
