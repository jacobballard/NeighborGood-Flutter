import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pastry/src/app/view/app.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/src/product/detail/view/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:repositories/repositories.dart';

import '../bloc/app_bloc.dart';

class GoRouterProvider {
  // final AppStatus authStatus;

  // const GoRouterProvider({
  //   // required this.authStatus,
  // });AppStatus authStatus
  GoRouter goRouter() {
    return GoRouter(
      // refreshListenable: authStatus,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AppView(),
          // routes: [GoRoute(path: '')])
        ),
        // GoRoute(
        //   path: '/store/:id',
        //   name: 'store',
        //   // builder: (context, state) => ,
        // ),
        GoRoute(
            path: '/store/:store_id/product/:id',
            name: 'product',
            builder: (context, state) => ProductDetailPage(
                    product: Product(
                  id: state.queryParameters['id'].toString(),
                  seller_id: state.queryParameters['store_id'].toString(),
                  name: "",
                  latitude: double.nan,
                  longitude: double.nan,
                  price: double.nan,
                ))),
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
        final authenticated = status == AppStatus.authenticated;
        final loggingOut = status == AppStatus.loggingOut;

        final onLoginPath = state.path == '/login';
        print('redirect');

        final loginRequest = state.fullPath == '/login';
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
}
