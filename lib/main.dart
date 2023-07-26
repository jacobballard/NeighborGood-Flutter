import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pastry/firebase_options.dart';
import 'package:pastry/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:repositories/repositories.dart';

import 'src/account/account/bloc/profile_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   final authenticationRepository = AuthenticationRepository();

//   await authenticationRepository.user.first;

//   runApp(App(
//     authenticationRepository: authenticationRepository,
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;

  final appBloc = AppBloc(authenticationRepository: authenticationRepository);
  final profileBloc = ProfileBloc(
    appBloc: appBloc,
    authenticationRepository: authenticationRepository,
  );
  if (authenticationRepository.currentUser.isEmpty && kIsWeb) {
    await authenticationRepository.signInAnonymously();
  }

  runApp(
    RepositoryProvider<AuthenticationRepository>.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>.value(value: appBloc),
          BlocProvider<LocationCubit>(
            create: (_) => LocationCubit()..initLocation(),
          ),
          BlocProvider<CartCubit>(
            create: (_) => CartCubit(
              firstStoreAddressCubit: StoreAddressCubit(),
              secondStoreAddressCubit: StoreAddressCubit(),
              authenticationRepository: _.read<AuthenticationRepository>(),
              cartRepository: CartRepository(),
            ),
          ),
          BlocProvider<ProfileBloc>.value(value: profileBloc),
        ],
        child: const App(),
      ),
    ),
  );
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   final authenticationRepository = AuthenticationRepository();

//   if (authenticationRepository.currentUser == User.empty && kIsWeb) {
//     print("should sign in anonymously");
//     await authenticationRepository.signInAnonymously();
//     print("did");
//   }

//   final appBloc = AppBloc(
//     authenticationRepository: authenticationRepository,
//   );

//   final profileBloc = ProfileBloc(
//     appBloc: appBloc,
//     profileRepository: ProfileRepository(
//       userId: null,
//       authenticationRepository: authenticationRepository,
//     ),
//   );

//   runApp(
//     RepositoryProvider<AuthenticationRepository>.value(
//       value: authenticationRepository,
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<AppBloc>.value(value: appBloc),
//           BlocProvider<LocationCubit>(
//             create: (_) => LocationCubit()..initLocation(),
//           ),
//           BlocProvider<CartCubit>(
//             create: (_) => CartCubit(
//               firstStoreAddressCubit: StoreAddressCubit(),
//               secondStoreAddressCubit: StoreAddressCubit(),
//               authenticationRepository: authenticationRepository,
//               cartRepository: CartRepository(),
//             ),
//           ),
//           BlocProvider<ProfileBloc>.value(value: profileBloc),
//         ],
//         child: BlocListener<AppBloc, AppState>(
//           listener: (context, state) {
//             print('listed');
//             print(state.status);
//             if (state.status == AppStatus.authenticated) {
//               print("adding :)");
//               profileBloc.add(ProfileUserChanged(state.user));
//             }
//           },
//           child: App(),
//         ),
//       ),
//     ),
//   );
// }
