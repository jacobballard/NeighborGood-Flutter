import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<GetLocationState> {
  LocationCubit() : super(LocationLoading());

  static LocationCubit get(context) => BlocProvider.of(context);

  late GeoPoint position;

  initLocation() async {
    emit(LocationLoading());
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    print("init location $isServiceEnabled");
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

    // print("done requesting");

    // if (permission == LocationPermission.deniedForever) {
    //   print("what!!!");
    //   emit(LocationUnknown());
    // } else if (permission == LocationPermission.denied) {
    //   print("what!!!!!");
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     emit(LocationUnknown());
    //     print("what!!!!!!!!!!");
    //   }
    // } else if (permission == LocationPermission.unableToDetermine) {
    //   emit(LocationUnknown());
    //   print("wha~!!!!!!!!!!!!");
    // } else {
    //   print("else???");
    //   getLocation();
    // }
  }

  Future<void> getLocation() async {
    print("Did we ever get here??");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      this.position = GeoPoint(position.latitude, position.longitude);
      emit(LocationKnown(this.position));
    }).catchError((error) {});
  }

  Future<void> getLocationFromZipCode(String zipCode) async {
    try {
      List<Location> locations = await locationFromAddress(zipCode);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        position = GeoPoint(location.latitude, location.longitude);
        emit(LocationKnown(position));
      } else {
        throw Exception('No location found for the provided zip code.');
      }
    } catch (e) {
      throw Exception('Error getting location from zip code: $e');
    }
  }
}
