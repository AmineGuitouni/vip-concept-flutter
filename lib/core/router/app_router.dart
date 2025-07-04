import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localboss/features/auth/view/pages/loading.dart';
import 'package:localboss/features/auth/view/pages/login_page.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart';
import 'package:localboss/features/business/view/pages/business_list.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/promoCode/views/pages/promo_code.dart';
import 'package:localboss/features/reviews/view/pages/reviews_page.dart';
import 'package:localboss/features/home/view/pages/home_page.dart';
import 'package:localboss/features/subscription/views/pages/manage_subscriptions.dart';

GoRouter goRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: authProvider.isLoggedIn ? '/loading' : '/login',
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),
      ShellRoute(
          builder: (context, state, child) {
            return HomeLayout(child: child);
          },
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: HomeContainer()),
            ),
            GoRoute(
              path: '/reviews',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ReviewsPage()),
            ),
          ]),
      GoRoute(
        path: '/businessList',
        pageBuilder: (context, state) =>
            const MaterialPage(child: BusinessList()),
      ),
      GoRoute(
        name: "loading",
        path: '/loading',
        pageBuilder: (context, state) =>
            const MaterialPage(child: Loading(opacity: 255)),
      ),
      GoRoute(
        path: '/manageSubscriptions',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ManageSubscriptions()),
      ),
      GoRoute(
        path: '/promoCode',
        pageBuilder: (context, state) =>
            const MaterialPage(child: PromoCode()),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authProvider.isLoggedIn;
      final isLoggingIn = state.fullPath == '/login';
      final isLoadingPath = state.fullPath == '/loading';

      if (authProvider.loading) {
        return "/loading";
      } else if (isLoadingPath) {
        return "/home";
      }

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/loading';

      return null;
    },
    refreshListenable: authProvider,
  );
}
