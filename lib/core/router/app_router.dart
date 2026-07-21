import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/features/grocery/screens/grocery_screen.dart';
import 'package:mealflow/features/home/screens/home_screen.dart';
import 'package:mealflow/features/home/screens/meal_form_screen.dart';
import 'package:mealflow/features/navigation/screens/navigation_screen.dart';
import 'package:mealflow/features/plan/screens/plan_screen.dart';
import 'package:mealflow/features/profile/screens/profile_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return NavigationScreen(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => HomeScreen()),
          GoRoute(path: '/plan', builder: (context, state) => PlanScreen()),
          GoRoute(
            path: '/grocery',
            builder: (context, state) => GroceryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),

      GoRoute(
        path: '/form',
        builder: (context, state) {
          final args = state.extra as MealFormArgs;

          return MealFormScreen(
            meal: args.meal,
            category: args.category,
            date: args.date,
          );
        },
      ),
    ],
  );
}
