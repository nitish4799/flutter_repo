import 'dart:io';

import 'package:flutter_repo/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> openDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final dbFile = path.join(dbPath, 'places.db');
  final db = await sql.openDatabase(
    dbFile,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await openDatabase();
    final data = await db.query('user_places');
    final places =
        data
            .map(
              (row) => Place(
                id: row['id'] as String,
                title: row['title'] as String,
                image: File(row['image'] as String),
                location: PlaceLocation(
                  address: row['address'] as String,
                  latitude: row['lat'] as double,
                  longitude: row['lng'] as double,
                ),
              ),
            )
            .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );
    final db = await openDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);
