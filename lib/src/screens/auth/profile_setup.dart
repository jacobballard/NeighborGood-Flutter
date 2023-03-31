// import 'package:flutter/material.dart';
// import 'package:pastry/repositories/authentication_repository.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:pastry/src/screens/tab_bar.dart';

// class ProfileSetupScreen extends StatefulWidget {
//   final AuthenticationRepository authRepo;

//   ProfileSetupScreen({Key? key, required this.authRepo}) : super(key: key);

//   @override
//   _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
// }

// class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   String _selectedRole = 'buyer';
//   LatLng _location = LatLng(0, 0);

//   Future<void> _submitProfileSetup() async {
//     if (_fullNameController.text.isNotEmpty &&
//         _usernameController.text.isNotEmpty &&
//         _locationController.text.isNotEmpty) {
//       try {
//         final _location = LatLng(
//           double.parse(_locationController.text.split(',')[0].trim()),
//           double.parse(_locationController.text.split(',')[1].trim()),
//         );

//         final user = await widget.authRepo.getCurrentUser();
//         final uid = user?.uid;

//         if (uid != null) {
//           await widget.authRepo.saveUserData(
//             uid: uid,
//             fullName: _fullNameController.text,
//             username: _usernameController.text,
//             location: _location,
//             role: _selectedRole,
//           );

//           if (context.mounted) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => MyTabBar()),
//               (route) => false,
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error getting user ID')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error saving user data: $e')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in all fields')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Setup'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _buildFullNameInput(),
//               _buildUsernameInput(),
//               _buildRoleSelection(),
//               _buildLocationButton(context),
//               _buildSaveProfileButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFullNameInput() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: _fullNameController,
//         decoration: InputDecoration(
//           labelText: 'Full Name',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUsernameInput() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: _usernameController,
//         decoration: InputDecoration(
//           labelText: 'Username',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRoleSelection() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: DropdownButton<String>(
//         hint: Text('Choose Role'),
//         value: _selectedRole,
//         onChanged: (String? newValue) {
//           setState(() {
//             if (newValue! != null) {
//               _selectedRole = newValue;
//             }
//           });
//         },
//         items: <String>['Buyer', 'Seller']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildLocationButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         Position position;
//         try {
//           position = await Geolocator.getCurrentPosition(
//               desiredAccuracy: LocationAccuracy.high);
//           // Store the location as latitude and longitude
//           setState(() {
//             _location = LatLng(position.latitude, position.longitude);
//           });
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error getting location: $e')),
//           );
//         }
//       },
//       child: Text('Get Location'),
//     );
//   }

//   Widget _buildSaveProfileButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         // Save user data to Firebase
//         try {
//           await _submitProfileSetup();

//           Navigator.pop(context);
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(e.toString())),
//           );
//         }
//       },
//       child: Text('Save Profile'),
//     );
//   }
// }
