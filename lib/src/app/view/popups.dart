// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pastry/src/auth/login/view/login_page.dart';

// import '../bloc/app_bloc.dart';

// class PopupHandler extends StatelessWidget {
//   const PopupHandler({required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AppBloc, AppState>(
//       listener: (context, state) {
//         if (state.status == AppStatus.unauthenticated) {
//           // Show the login popup
//           showDialog(
//             context: context,
//             builder: (context) => LoginPage(),
//           );
//         }
//       },
//       child: BlocListener<LocationBloc, LocationState>(
//         listener: (context, state) {
//           if (state is LocationInitial) {
//             // Show the location request popup
//           }
//         },
//         child: child,
//       ),
//     );
//   }
// }
