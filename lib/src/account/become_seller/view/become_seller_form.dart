import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/become_seller/cubit/become_seller_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';

class BecomeSellerForm extends StatelessWidget {
  const BecomeSellerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final locationCubit = context.read<LocationCubit>();
      if (locationCubit.position != null) {
        context
            .read<BecomeSellerCubit>()
            .storeLatitudeChanged(locationCubit.position!.latitude);
        context
            .read<BecomeSellerCubit>()
            .storeLongitudeChanged(locationCubit.position!.longitude);
      }
    });

    return BlocListener<BecomeSellerCubit, BecomeSellerState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Store Creation Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleInput(),
            const SizedBox(height: 8),
            _DescriptionInput(),
            const SizedBox(height: 8),
            _InstaInput(),
            const SizedBox(height: 8),
            _TikInput(),
            const SizedBox(height: 8),
            _MetaInput(),
            const SizedBox(height: 8),
            _PinInput(),
            const SizedBox(height: 8),
            _CreateStoreButton(),
            const SizedBox(height: 8),
            _LocationInput(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeTitle != current.storeTitle,
      builder: (context, state) {
        return TextField(
          onChanged: (title) =>
              context.read<BecomeSellerCubit>().storeTitleChanged(title),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Store Title',
            helperText: '',
            errorText:
                state.storeTitle.invalid ? 'Store title is required' : null,
          ),
        );
      },
    );
  }
}

// Add similar widgets for Description, Insta, Tik, Meta, and Pin inputs
// based on the validators you created previously

class _CreateStoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () async {
                        await context.read<BecomeSellerCubit>().createStore();
                      }
                    : null,
                child: const Text('Create Store'),
              );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeDescription != current.storeDescription,
      builder: (context, state) {
        return TextField(
          onChanged: (description) => context
              .read<BecomeSellerCubit>()
              .storeDescriptionChanged(description),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Store Description (optional)',
            helperText: '',
            errorText:
                state.storeDescription.invalid ? 'Invalid description' : null,
          ),
        );
      },
    );
  }
}

class _InstaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeInsta != current.storeInsta,
      builder: (context, state) {
        return TextField(
          onChanged: (insta) =>
              context.read<BecomeSellerCubit>().storeInstaChanged(insta),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Instagram Handle (optional)',
            helperText: '',
            errorText:
                state.storeInsta.invalid ? 'Invalid Instagram handle' : null,
          ),
        );
      },
    );
  }
}

class _TikInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storeTik != current.storeTik,
      builder: (context, state) {
        return TextField(
          onChanged: (tik) =>
              context.read<BecomeSellerCubit>().storeTikChanged(tik),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'TikTok Handle (optional)',
            helperText: '',
            errorText: state.storeTik.invalid ? 'Invalid TikTok handle' : null,
          ),
        );
      },
    );
  }
}

class _MetaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storeMeta != current.storeMeta,
      builder: (context, state) {
        return TextField(
          onChanged: (meta) =>
              context.read<BecomeSellerCubit>().storeMetaChanged(meta),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Meta Handle (optional)',
            helperText: '',
            errorText: state.storeMeta.invalid ? 'Invalid Meta handle' : null,
          ),
        );
      },
    );
  }
}

class _PinInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storePin != current.storePin,
      builder: (context, state) {
        return TextField(
          onChanged: (pin) =>
              context.read<BecomeSellerCubit>().storePinChanged(pin),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Pinterest Handle (optional)',
            helperText: '',
            errorText:
                state.storePin.invalid ? 'Invalid Pinterest handle' : null,
          ),
        );
      },
    );
  }
}

class _LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<_LocationInput> {
  late GoogleMapController mapController;
  double? _lastLatPosition;
  double? _lastLngPosition;

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _onCameraMove(CameraPosition position) {
    _lastLatPosition = position.target.latitude;
    _lastLngPosition = position.target.longitude;
  }

  _onCameraIdle() {
    if (_lastLatPosition != null && _lastLngPosition != null) {
      context.read<BecomeSellerCubit>().storeLatitudeChanged(_lastLatPosition!);
      context
          .read<BecomeSellerCubit>()
          .storeLongitudeChanged(_lastLngPosition!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GeoPoint initialLocation =
        context.read<LocationCubit>().position ??= const GeoPoint(0.0, 0.0);

    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeLatitude != current.storeLatitude ||
          previous.storeLongitude != current.storeLongitude,
      builder: (context, state) {
        return SizedBox(
          height: 300, // Change this to fit your needs
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                initialLocation.latitude,
                initialLocation.longitude,
              ), // This should be your initial position
              zoom: 14.0,
            ),
            markers: {
              Marker(
                  markerId: const MarkerId('storeLocation'),
                  position: LatLng(
                    state.storeLatitude.value,
                    state.storeLongitude.value,
                  ),
                  draggable: true,
                  onDragEnd: (newPosition) {
                    context
                        .read<BecomeSellerCubit>()
                        .storeLatitudeChanged(newPosition.latitude);
                    context
                        .read<BecomeSellerCubit>()
                        .storeLongitudeChanged(newPosition.longitude);
                  })
            },
          ),
        );
      },
    );
  }
}
