import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 34),

          AppSpacing.horizontalMD,

          Expanded(
            child: Column(
              children: [
                Text('User', style: Theme.of(context).textTheme.titleLarge),

                AppSpacing.verticalXS,

                Text(
                  'Flutter Developer',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),

          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
