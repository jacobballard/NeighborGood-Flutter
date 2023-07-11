import 'package:go_router/go_router.dart';
import 'package:pastry/src/app/view/app.dart';
import 'package:pastry/src/product/detail/view/product_detail.dart';
import 'package:repositories/repositories.dart';

class GoRouterProvider {
  GoRouter get goRouter {
    return GoRouter(routes: [
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
              )))
    ]);
  }
}
