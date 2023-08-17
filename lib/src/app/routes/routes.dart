import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pastry/src/app/view/app.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/src/product/detail/view/product_detail.dart';
import 'package:pastry/src/store/detail/view/store_detail.dart';
import 'package:provider/provider.dart';
import 'package:repositories/repositories.dart';

import '../bloc/app_bloc.dart';

mixin GoRouterMixin on State<App> {
  // final AppStatus authStatus;

  // const GoRouterProvider({
  //   // required this.authStatus,
  // });AppStatus authStatus
  late final AppBloc _appBloc;
  late final GoRouter _router;

  void init(AppBloc appBloc) {
    _appBloc = appBloc;

    _router = GoRouter(
      refreshListenable: GoRouterRefreshStream(_appBloc.stream),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AppView(),
          routes: [
            GoRoute(
              path: 'store/:store_id',
              name: 'store',
              builder: (context, state) {
                print('here !!!  ${state.matchedLocation}');
                return StoreDetailPage(
                    sellerId: state.pathParameters['store_id'].toString());
              },
              // routes: [
              //   GoRoute(
              //       // path: 'store/:store_id/product/:id',
              //       path: 'product/:id',
              //       name: 'product',
              //       builder: (context, state) {
              //         print('ew');
              //         return ProductDetailPage(
              //             product: ProductQuick(
              //           id: state.pathParameters['id'].toString(),
              //           seller_id: state.pathParameters['store_id'].toString(),
              //           name: "",
              //           latitude: double.nan,
              //           longitude: double.nan,
              //           price: double.nan,
              //         ));
              //       }),
              // ],
            ),
            GoRoute(
                path: 'store/:store_id/product/:id',
                // path: 'product/:id',
                name: 'product',
                builder: (context, state) {
                  print('ew');
                  return ProductDetailPage(
                      product: ProductQuick(
                    id: state.pathParameters['id'].toString(),
                    seller_id: state.pathParameters['store_id'].toString(),
                    name: "",
                    latitude: double.nan,
                    longitude: double.nan,
                    price: double.nan,
                  ));
                }),
          ],
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => BlocProvider(
            create: (context) => LoginCubit(
              context.read<AuthenticationRepository>(),
            ),
            child: const LoginPage(),
          ),
        )
      ],
      redirect: (context, state) {
        // final status = context.watch<AppBloc>().state.status;
        final status =
            Provider.of<AppBloc>(context, listen: false).state.status;
        print('stutaa');
        print(status);
        final authenticated = status == AppStatus.authenticated;
        final loggingOut = status == AppStatus.loggingOut;

        final onLoginPath = state.matchedLocation == '/login';
        print('redirect');

        final loginRequest = state.fullPath == '/login';
        print('matched');
        print(state.matchedLocation);
        print(state.fullPath);
        print(state.name);
        // print(authenticated);
        print(onLoginPath);
        print(kIsWeb);
        if (!authenticated && !onLoginPath && !kIsWeb) {
          return '/login';
        }

        if (!authenticated && loginRequest && !onLoginPath && kIsWeb) {
          return '/login';
        }

        if (authenticated && onLoginPath) {
          return '/';
        }
        return null;
      },
    );
  }

  GoRouter get router => _router;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
