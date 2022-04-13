import 'package:flutter/material.dart';
import 'package:mine_calculator/features/presentation/pages/blending_nikel/by_tonage_addoredit_screen.dart';
import 'package:mine_calculator/features/presentation/pages/blending_nikel/by_tonage_detail_screen.dart';
import 'package:mine_calculator/features/presentation/pages/blending_nikel/by_tonage_screen.dart';
import 'package:mine_calculator/features/presentation/pages/home_screen.dart';
import 'package:mine_calculator/features/presentation/routes/app_routes.dart';

class AppPages {
  Route? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      // case Routes.splash:
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.byTonageScreen:
        return MaterialPageRoute(
          builder: (_) => const ByTonageScreen(),
        );
      case Routes.byTonageDetailScreen:
        return MaterialPageRoute(
          builder: (_) {
            if (args is Map) {
              return ByTonageDetailScreen(slot: args["key-slot"]);
            }
            return _pageNotFound();
          },
        );
      case Routes.byTonageAddOrEditScreen:
        return MaterialPageRoute(
          builder: (_) => const ByTonageAddOrEditScreen(),
        );
      default:
        throw 'Route ${settings.name} is not defined';
    }
  }

  static _pageNotFound() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opps"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Page Not Found',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
