import 'package:flutter/material.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';

class LocationPopup extends StatefulWidget {
  const LocationPopup({super.key});

  @override
  LocationPopupState createState() => LocationPopupState();
}

class LocationPopupState extends State<LocationPopup> {
  final TextEditingController _zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Zip Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _zipController,
            decoration: const InputDecoration(
              labelText: 'Zip Code',
              hintText: 'Enter your zip code',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              try {
                final locationCubit = LocationCubit.get(context);
                await locationCubit.getLocationFromZipCode(_zipController.text);
                // TODO: Maybe do something with the location (latitude and longitude)
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
