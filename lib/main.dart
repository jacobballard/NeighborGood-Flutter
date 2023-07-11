import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:pastry/firebase_options.dart';
import 'package:pastry/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
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

  runApp(
    RepositoryProvider<AuthenticationRepository>.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
                authenticationRepository: _.read<AuthenticationRepository>()),
          ),
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
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              appBloc: _.read<AppBloc>(),
              profileRepository: ProfileRepository(
                userId: null,
                authenticationRepository: _.read<AuthenticationRepository>(),
              ),
            ),
          ),
        ],
        child: App(),
      ),
    ),
  );
}
