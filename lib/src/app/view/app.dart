import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/create_store/cubit/store_address_cubit.dart';
import 'package:pastry/src/app/app.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';
import 'package:pastry/src/app/location/view/location.dart';
import 'package:pastry/src/app/view/tab_bar.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/src/auth/signup/signup.dart';
import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';
import 'package:pastry/theme.dart';
import 'package:provider/provider.dart';
import 'package:repositories/repositories.dart';

// class App extends StatelessWidget {
//   const App({
//     Key? key,
//     required AuthenticationRepository authenticationRepository,
//   })  : _authenticationRepository = authenticationRepository,
//         super(key: key);

//   final AuthenticationRepository _authenticationRepository;

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: _authenticationRepository,
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<AppBloc>(
//             create: (_) => AppBloc(
//                 authenticationRepository:
//                     context.read<AuthenticationRepository>()),
//           ),
//           BlocProvider<LocationCubit>(
//             create: (_) => LocationCubit()..initLocation(),
//           ),
//           BlocProvider<CartCubit>(
//             create: (_) => CartCubit(
//               firstStoreAddressCubit: StoreAddressCubit(),
//               secondStoreAddressCubit: StoreAddressCubit(),
//               authenticationRepository:
//                   context.read<AuthenticationRepository>(),
//               cartRepository: CartRepository(),
//             ),
//           ),
//           BlocProvider<ProfileBloc>(
//             create: (_) => ProfileBloc(
//               appBloc: context.read<AppBloc>(),
//               profileRepository: ProfileRepository(
//                 userId: null,
//                 authenticationRepository:
//                     context.read<AuthenticationRepository>(),
//               ),
//             ),
//           ),
//         ],
//         child: MaterialApp.router(
//           routerConfig: GoRouterProvider().goRouter,
//           theme: theme,
//           darkTheme: darkTheme,
//         ),
//         // child: MaterialApp(
//         //   theme: theme,
//         //   darkTheme: darkTheme,
//         //   // home: const AppWithAuthAndLocationListener(),

//       ),
//     );
//   }
// }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with GoRouterMixin {
  // const App({Key? key}) : super(key: key);
  @override
  void initState() {
    super.initState();
    init(Provider.of<AppBloc>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AppBloc, AppState>(
    //   buildWhen: (previous, current) => previous.status != current.status,
    //   builder: (context, state) => MaterialApp.router(
    //     routerConfig: GoRouterProvider().goRouter(
    //       state.status,
    //     ),
    //     theme: theme,
    //     darkTheme: darkTheme,
    //   ),
    // );
    // Provider.of<AppBloc>(context);
    return MaterialApp.router(
      routerConfig: router,
      theme: theme,
      darkTheme: darkTheme,
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

// class AppWithAuthAndLocationListener extends StatelessWidget {
//   const AppWithAuthAndLocationListener({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AppBloc, AppState>(
//       // listenWhen: (previous, current) => previous.status != current.status,
//       listener: (context, state) {
//         if (state.status == AppStatus.unauthenticated) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             showAuthDialog(context);
//           });
//         } else if (state.status == AppStatus.authenticated) {
//           final locationState = context.read<LocationCubit>().state;
//           if (locationState is LocationUnknown) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _showLocationPopup(context);
//             });
//           }
//         }
//       },
//       child: BlocBuilder<AppBloc, AppState>(
//         buildWhen: (previous, current) => previous != current,
//         builder: (context, state) {
//           print("builder");

//           if (state.status == AppStatus.authenticated) {
//             print("Should reBuild");
//             return BlocProvider.value(
//               value: ProfileBloc(
//                 appBloc: context.read<AppBloc>(),
//                 profileRepository: ProfileRepository(
//                   userId: state.user.id,
//                   authenticationRepository:
//                       context.read<AuthenticationRepository>(),
//                 ),
//               ),
//               child: const AppView(),
//             );
//           } else {
//             print("else :(");
//             return BlocProvider.value(
//               value: ProfileBloc(
//                 appBloc: context.read<AppBloc>(),
//                 profileRepository: ProfileRepository(
//                   userId: null,
//                   authenticationRepository:
//                       context.read<AuthenticationRepository>(),
//                 ),
//               ),
//               child: const AppView(),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<void> showAuthDialog(BuildContext context) async {
//     // ignore: unused_local_variable
//     final result = await showDialog<bool>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => AuthPopupCubit(
//                 authenticationRepository:
//                     context.read<AuthenticationRepository>(),
//               ),
//             ),
//             BlocProvider(
//               create: (context) =>
//                   LoginCubit(context.read<AuthenticationRepository>()),
//             ),
//           ],
//           child: BlocBuilder<AuthPopupCubit, AuthPopupType>(
//             builder: (context, state) {
//               if (state == AuthPopupType.login) {
//                 return GestureDetector(
//                   onTap: () async {
//                     await context.read<LoginCubit>().signInAnonymously();
//                     if (context.mounted) Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     child: const Center(
//                       child: LoginPage(),
//                     ),
//                   ),
//                 );
//               } else if (state == AuthPopupType.signUp) {
//                 return Container(
//                   color: Colors.transparent,
//                   child: const Center(
//                     child: SignUpPage(),
//                   ),
//                 );
//               }
//               // else if (state == AuthPopupType.verify) {
//               //   return Container(
//               //     color: Colors.transparent,
//               //     child: const Center(
//               //       child: EmailVerificationPage(),
//               //     ),
//               //   );
//               // }
//               return Container(); // This should never happen
//             },
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _showLocationPopup(BuildContext context) async {
//     await showDialog<bool>(
//       context: context,
//       barrierDismissible: true, // barrier is dismissible
//       builder: (BuildContext context) {
//         return BlocProvider(
//           create: (context) => LocationCubit(),
//           child: Builder(
//             builder: (BuildContext innerContext) {
//               return GestureDetector(
//                 onTap: () {
//                   // innerContext.read<LocationCubit>().
//                   Navigator.of(innerContext).pop(); // Close the popup
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   child: const Center(
//                     child: LocationPopup(),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }



// class AuthPopupCubit extends Cubit<AuthPopupState> {
//   AuthPopupCubit() : super(AuthPopupState.login);

//   void showVerify() => emit(AuthPopupState.verify);
//   void showSignUp() => emit(AuthPopupState.signUp);
//   void showLogin() => emit(AuthPopupState.login);
// }
