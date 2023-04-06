import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:pastry/src/app/app.dart';
import 'package:pastry/src/location/bloc/location_bloc.dart';

class ZipCodeScreen extends StatefulWidget {
  const ZipCodeScreen({super.key});

  @override
  ZipCodeScreenState createState() => ZipCodeScreenState();
}

class ZipCodeScreenState extends State<ZipCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _zipCodeController = TextEditingController();
  ZipCodeInput _zipCodeInput = const ZipCodeInput.pure();

  void _onZipCodeChanged() {
    setState(() {
      _zipCodeInput = ZipCodeInput.dirty(_zipCodeController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _zipCodeController.addListener(_onZipCodeChanged);
  }

  @override
  void dispose() {
    _zipCodeController.removeListener(_onZipCodeChanged);
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Zip Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _zipCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Zip Code'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _zipCodeInput.valid
                    ? () {
                        BlocProvider.of<LocationBloc>(context).add(
                          SubmitZipCodeEvent(_zipCodeController.text),
                        );

                        // Add this block of code to handle the callback
                        context.read<LocationBloc>().stream.listen((state) {
                          if (state is LocationLoaded) {
                            context.read<AppBloc>().add(AppLocationUpdated());
                            Navigator.of(context).pop();
                          } else if (state is LocationError) {
                            final snackBar = SnackBar(
                              content: Text(state.message),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    : () {
                        const snackBar = SnackBar(
                          content:
                              Text('Please enter a valid 5-digit zip code'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZipCodeScreenPage extends Page {
  const ZipCodeScreenPage() : super(key: const ValueKey('ZipCodeScreen'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider<LocationBloc>(
        create: (_) => LocationBloc(),
        child: const ZipCodeScreen(),
      ),
    );
  }
}
