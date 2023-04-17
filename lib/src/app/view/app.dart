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
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

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
        child: const AppView(),
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
    return MaterialApp(
      theme: theme,
      home: const MyTabBar(),
    );
  }
}

class AppWithAuthAndLocationListener extends StatelessWidget {
  const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.status == AppStatus.unauthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showLoginPopup(context);
              });
            }
          },
        ),
        BlocListener<LocationCubit, GetLocationState>(
          listener: (context, locationState) {
            final appStatus =
                context.select((AppBloc bloc) => bloc.state.status);
            if (appStatus == AppStatus.authenticated &&
                locationState is LocationUnknown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showLocationPopup(context);
              });
            }
          },
        ),
      ],
      child: const AppView(),
    );
  }

  Future<void> _showLoginPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BlocProvider<LoginCubit>(
          create: (context) =>
              LoginCubit(context.read<AuthenticationRepository>()),
          child: GestureDetector(
            onTap: () {
              // Access the LoginCubit and execute your command
              context.read<LoginCubit>().signInAnonymously();
              Navigator.of(context).pop(); // Close the popup
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const LoginPage(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLocationPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Execute your command here, e.g., context.read<LocationCubit>().yourCommand();
            Navigator.of(context).pop(); // Close the popup
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: BlocProvider<LocationCubit>(
                  create: (context) => LocationCubit(),
                  child: const LocationPopup(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
