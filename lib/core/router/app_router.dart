import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vision/features/notifications/presentation/notification_page.dart';
import 'package:vision/features/profile/presentation/pages/settings_page.dart';
import '../../../features/auth/presentation/auth/login_page.dart';
import '../../../features/home/presentation/home_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../widgets/root_navbar.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/app',
        builder: (context, state) => const RootNavbar(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),

      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const  ProfileInfoPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const  AdminDashboardPage(),
      ),
    ],
  );
});
