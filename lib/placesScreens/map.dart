import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      address: 'default address',
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelecting = true,
  });
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DitchText(
          text: widget.isSelecting ? 'Pick your location' : 'Your Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap:
            widget.isSelecting == false
                ? null
                : (position) {
                  setState(() {
                    _pickedLocation = position;
                  });
                },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers:
            (_pickedLocation == null && widget.isSelecting)
                ? {}
                : {
                  Marker(
                    markerId: MarkerId('m1'),
                    position:
                        _pickedLocation ??
                        LatLng(
                          widget.location.latitude,
                          widget.location.longitude,
                        ),
                  ),
                },
      ),
    );
  }
}
