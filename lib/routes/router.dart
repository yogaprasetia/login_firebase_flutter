import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/page/detail_products.dart';
import 'package:qrcode_bloc/page/error.dart';
import 'package:qrcode_bloc/page/login.dart';
import 'package:qrcode_bloc/page/products.dart';
import 'package:qrcode_bloc/page/settings.dart';
import '../page/home.dart';
export 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'router_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return "/login";
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
        path: '/',
        name: Routes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              path: 'products',
              name: Routes.products,
              builder: (context, state) => const ProductsPage(),
              routes: [
                GoRoute(
                    path: ':id',
                    name: Routes.detailProduct,
                    builder: (context, state) => DetailProducts(
                        state.pathParameters['id'].toString(),
                        state.uri.queryParameters)),
              ])
        ]),
    GoRoute(
      path: '/settings',
      name: Routes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    )
  ],
);
