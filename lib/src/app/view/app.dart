import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/bloc/app_bloc.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';
import 'package:pastry/src/app/location/view/location.dart';
import 'package:pastry/src/app/view/tab_bar.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<LocationCubit>(
            create: (_) => LocationCubit()..initLocation(),
          ),
        ],
        child: MaterialApp(
          theme: theme,
          home: const AppWithAuthAndLocationListener(),
        ),
      ),
    );
  }
}

// class AppView extends StatelessWidget {
//   const AppView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: theme,
//       home: FlowBuilder<AppStatus>(
//         state: context.select((AppBloc bloc) => bloc.state.status),
//         onGeneratePages: onGenerateAppViewPages,
//       ),
//     );
//   }
// }

// class AppView extends StatelessWidget {
//   const AppView({super.key});

//   Widget _buildSplashScreen() {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: theme,
//       home: BlocListener<AppBloc, AppState>(
//         listener: (context, state) {
//           if (state.status == AppStatus.unauthenticated) {
//             WidgetsBinding.instance?.addPostFrameCallback((_) {
//               // Show login popup
//             });
//           }
//         },
//         child: BlocBuilder<AppBloc, AppState>(
//           builder: (context, state) {
//             if (state.status == AppStatus.authenticated) {
//               return BlocListener<LocationCubit, GetLocationState>(
//                 listener: (context, locationState) {
//                   if (locationState is LocationUnknown) {
//                     WidgetsBinding.instance?.addPostFrameCallback((_) {
//                       // Show location popup
//                     });
//                   }
//                 },
//                 child: MyTabBar(),
//               );
//             }
//             return _buildSplashScreen();
//           },
//         ),
//       ),
//     );
//   }
// }
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyTabBar();
    // var loc_cubit = context.read<LocationCubit>();

    // return BlocBuilder<LocationCubit, GetLocationState>(builder: ((context, state) {
    //   if (state is LocationLoading) {
    //     print("Built LocationLoading!!");
    //   } else {
    //     print("we're working on it okay? ");
    //   }
    //   return const MyTabBar();
    // }));
  }
}

// class AppWithAuthAndLocationListener extends StatelessWidget {
//   const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppBloc, AppState>(
//       builder: (context, state) {
//         if (state.status == AppStatus.unauthenticated) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showLoginPopup(context);
//           });
//           return const AppView();
//         } else {
//           return BlocListener<LocationCubit, GetLocationState>(
//             listener: (locationContext, locationState) {
//               print(
//                   "got the status outside checking for location?? state: $locationState");

//               if (locationState is LocationUnknown) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   print("I gotta make it here?? locationPopup");
//                   _showLocationPopup(locationContext);
//                 });
//               } else {
//                 print(locationState);
//               }
//             },
//             child: const AppView(),
//           );
//         }
//       },
//     );
//   }
// class AppWithAuthAndLocationListener extends StatelessWidget {
//   const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AppBloc, AppState>(
//       listener: (context, state) {
//         if (state.status == AppStatus.unauthenticated) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showLoginPopup(context);
//           });
//         }
//       },
//       child: Builder(
//         builder: (context) {
//           return BlocListener<LocationCubit, GetLocationState>(
//             listener: (locationContext, locationState) {
//               final appState = context.read<AppBloc>().state;
//               if (appState.status == AppStatus.authenticated &&
//                   locationState is LocationUnknown) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   _showLocationPopup(locationContext);
//                 });
//               }
//             },
//             child: const AppView(),
//           );
//         },
//       ),
//     );
//   }
// class AppWithAuthAndLocationListener extends StatelessWidget {
//   const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AppBloc, AppState>(
//       listener: (context, state) {
//         if (state.status == AppStatus.unauthenticated) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showLoginPopup(context);
//           });
//         }
//       },
//       child: Builder(
//         builder: (context) {
//           return BlocBuilder<LocationCubit, GetLocationState>(
//             builder: (locationContext, locationState) {
//               print("building");
//               final appState = context.read<AppBloc>().state;
//               if (appState.status == AppStatus.authenticated &&
//                   locationState is LocationUnknown) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   _showLocationPopup(locationContext);
//                 });
//               }
//               return const AppView();
//             },
//           );
//         },
//       ),
//     );
//   }
class AppWithAuthAndLocationListener extends StatelessWidget {
  const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      // listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AppStatus.unauthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showLoginPopup(context);
          });
        } else if (state.status == AppStatus.authenticated) {
          final locationState = context.read<LocationCubit>().state;
          if (locationState is LocationUnknown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showLocationPopup(context);
            });
          }
        }
      },
      child: const AppView(),
    );
  }

// class AppWithAuthAndLocationListener extends StatelessWidget {
//   const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppBloc, AppState>(
//       builder: (context, appState) {
//         if (appState.status == AppStatus.unauthenticated) {
//           print("Authenticated??");
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             print("I gotta make it here?? loginPopup");
//             _showLoginPopup(context);
//           });
//         } else {
//           print("Wowwsow we in??");
//         }

//         return BlocBuilder<LocationCubit, GetLocationState>(
//           builder: (context, locationState) {
//             print('Location builder called with state: $locationState');
//             final appStatus =
//                 context.select((AppBloc bloc) => bloc.state.status);

//             if (appStatus == AppStatus.authenticated &&
//                 locationState is LocationUnknown) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 print("I gotta make it here?? locationPopup");
//                 _showLocationPopup(context);
//               });
//             } else {
//               print(locationState);
//             }

//             return const AppView();
//           },
//         );
//       },
//     );
//   }

  // Future<void> _showLoginPopup(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Builder(
  //         builder: (BuildContext innerContext) {
  //           return BlocProvider<LoginCubit>(
  //             create: (innerContext) =>
  //                 LoginCubit(innerContext.read<AuthenticationRepository>()),
  //             child: GestureDetector(
  //               onTap: () {
  //                 print("Tapping barrier??");
  //                 // Access the LoginCubit and execute your command
  //                 innerContext.read<LoginCubit>().signInAnonymously();
  //                 Navigator.of(innerContext).pop(); // Close the popup
  //               },
  //               child: Container(
  //                 color: Colors.transparent,
  //                 child: Center(
  //                   child: GestureDetector(
  //                     onTap: () {},
  //                     child: const LoginPage(),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // BlocProvider<LoginCubit>(
  //               create: (context) =>
  //                   LoginCubit(context.read<AuthenticationRepository>()),
  //               child: const LoginPage(),
  //             ),

  // Future<void> _showLoginPopup(BuildContext context) async {
  //   final result = await showDialog<bool>(
  //     context: context,
  //     barrierDismissible: true, // barrier is dismissible
  //     builder: (BuildContext context) {
  //       return BlocProvider(
  //         create: (context) =>
  //             LoginCubit(context.read<AuthenticationRepository>()),
  //         child: GestureDetector(
  //           onTap: () {
  //             context.read<LoginCubit>().signInAnonymously();
  //             Navigator.of(context).pop();
  //           },
  //           child: Container(
  //             color: Colors.transparent,
  //             child: Center(
  //               child: const LoginPage(),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> _showLoginPopup(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true, // barrier is dismissible
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) =>
              LoginCubit(context.read<AuthenticationRepository>()),
          child: Builder(
            builder: (BuildContext innerContext) {
              return GestureDetector(
                onTap: () async {
                  await innerContext.read<LoginCubit>().signInAnonymously();
                  Navigator.of(innerContext).pop();
                },
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: LoginPage(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Future<void> _showLoginPopup(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return GestureDetector(
  //         onTap: () {
  //           // Access the LoginCubit and execute your command
  //           context.read<LoginCubit>().signInAnonymously();
  //           Navigator.of(context).pop(); // Close the popup
  //         },
  //         child: Container(
  //           color: Colors.transparent,
  //           child: Center(
  //             child: GestureDetector(
  //               onTap:
  //                   () {}, // Prevent the onTap of the parent GestureDetector from triggering
  //               child: BlocProvider<LoginCubit>(
  //                 create: (context) =>
  //                     LoginCubit(context.read<AuthenticationRepository>()),
  //                 child: const LoginPage(),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> _showLocationPopup(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return GestureDetector(
  //         onTap: () {
  //           // Execute your command here, e.g., context.read<LocationCubit>().yourCommand();
  //           Navigator.of(context).pop(); // Close the popup
  //         },
  //         child: Container(
  //           color: Colors.transparent,
  //           child: Center(
  //             child: GestureDetector(
  //               onTap: () {},
  //               child: BlocProvider<LocationCubit>(
  //                 create: (context) => LocationCubit(),
  //                 child: const LocationPopup(),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> _showLocationPopup(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: true, // barrier is dismissible
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => LocationCubit(),
          child: Builder(
            builder: (BuildContext innerContext) {
              return GestureDetector(
                onTap: () {
                  // innerContext.read<LocationCubit>().
                  Navigator.of(innerContext).pop(); // Close the popup
                },
                child: Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: LocationPopup(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
