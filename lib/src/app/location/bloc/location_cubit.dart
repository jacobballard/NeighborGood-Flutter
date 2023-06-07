import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'location_state.dart';

class LocationCubit extends Cubit<GetLocationState> {
  LocationCubit() : super(LocationLoading());

  static LocationCubit get(context) => BlocProvider.of(context);

  GeoPoint? position;

  initLocation() async {
    emit(LocationLoading());
    // bool isServiceEnabled;
    LocationPermission permission;

    await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        emit(LocationUnknown());
      } else {
        getLocation();
      }
    } else {
      getLocation();
    }
  }

  Future<void> getLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      this.position = GeoPoint(position.latitude, position.longitude);
      emit(LocationKnown(this.position!));
    }).catchError((error) {});
  }

  Future<void> getLocationFromZipCode(String zipCode) async {
    try {
      final queryParameters = {
        'address': zipCode,
        'key': 'AIzaSyBVxgYIPrE6QCMoZpRc6gWPssHELQzBwqE',
      };

      final uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        queryParameters,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final lat = data['results'][0]['geometry']['location']['lat'];
        final lng = data['results'][0]['geometry']['location']['lng'];

        GeoPoint position = GeoPoint(lat, lng);
        emit(LocationKnown(position));
      } else {
        throw Exception('Failed to load geocoding data');
      }
    } catch (e) {
      throw Exception('Error getting location from zip code: $e');
    }
  }
}

//AIzaSyBVxgYIPrE6QCMoZpRc6gWPssHELQzBwqE