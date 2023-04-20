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

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyTabBar();
  }
}

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
                  if (context.mounted) Navigator.of(innerContext).pop();
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
