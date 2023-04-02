import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocationEvent>(_onGetLocationEvent);
    on<UpdateLocationEvent>(_onUpdateLocationEvent);
    on<SubmitZipCodeEvent>(_onSubmitZipCodeEvent);
  }

  Future<void> _onGetLocationEvent(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    print("Locating loading!");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double? latitude = prefs.getDouble('latitude');
      double? longitude = prefs.getDouble('longitude');

      if (latitude == null || longitude == null) {
        Location location = new Location();
        LocationData locationData = await location.getLocation();
        latitude = locationData.latitude;
        longitude = locationData.longitude;

        if (latitude != null && longitude != null) {
          await prefs.setDouble('latitude', latitude);
          await prefs.setDouble('longitude', longitude);
          emit(LocationLoaded(latitude, longitude));
        } else {
          emit(LocationError("idek how that failed :("));
        }
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _onUpdateLocationEvent(
    UpdateLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    // Save the location to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', event.latitude);
    await prefs.setDouble('longitude', event.longitude);

    // Emit the updated location state
    emit(LocationLoaded(event.latitude, event.longitude));

    // Invoke the callback function
    if (event.onLocationUpdated != null) {
      event.onLocationUpdated!();
    }
  }

  Future<void> _onSubmitZipCodeEvent(
    SubmitZipCodeEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      print("trying :::!");
      var response = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/search?postalcode=${event.zipCode}&format=json'));

      if (response.statusCode == 200) {
        print("ok ${response.body}");
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.isNotEmpty) {
          double latitude = double.parse(jsonResponse[0]['lat']);
          double longitude = double.parse(jsonResponse[0]['lon']);

          _onUpdateLocationEvent(
            UpdateLocationEvent(
              latitude: latitude,
              longitude: longitude,
              onLocationUpdated: null, // Pass null here
            ),
            emit,
          );
        } else {
          emit(LocationError('Failed to find location for the given zip code'));
        }
      } else {
        emit(LocationError('Failed to load location data'));
      }
    } catch (e) {
      print(e);
      emit(LocationError(
          'Error: Unable to convert zip code to latitude and longitude'));
    }
  }
}
