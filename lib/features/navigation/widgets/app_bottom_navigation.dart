import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    int currentIndex = switch (location) {
      '/' => 0,
      '/plan' => 1,
      '/grocery' => 2,
      '/profile' => 3,
      _ => 0,
    };

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: AppColors.primaryLight,

        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : Colors.grey,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),

          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Plan',
            selectedIcon: Icon(Icons.task_alt),
          ),

          NavigationDestination(
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Grocery',
            selectedIcon: Icon(Icons.local_grocery_store),
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            selectedIcon: Icon(Icons.person),
          ),
        ],

        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/plan');
              break;
            case 2:
              context.go('/grocery');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
