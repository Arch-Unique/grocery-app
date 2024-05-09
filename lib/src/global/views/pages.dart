import 'package:get/get.dart';
import 'package:grocery_app/src/features/authpage.dart';
import 'package:grocery_app/src/features/homepage.dart';

import '../../features/onboarding_screen.dart';
import '../../src_barrel.dart';
import '../../utils/constants/routes/middleware/auth_middleware.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        middlewares: [AuthMiddleWare()]),
    GetPage(name: AppRoutes.auth, page: () => AuthPage()),
    // GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
  ];
}
