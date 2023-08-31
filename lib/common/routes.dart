import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myfinance/core/main_screen.dart';
import '../core/auth/auth_screen.dart';
import 'page_404.dart';

class AppRoutesConstants {
  static const main = "main";
  static const createRecord = "createRecord";
  static const auth = "auth";
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => ErrorScreen(e: state.error.toString()),
    routes: [
      GoRoute(
        name: AppRoutesConstants.main,
        path: "/",
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: AppRoutesConstants.auth,
        path: "/auth",
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
});
