import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/widgets/grocery_item_card.dart';

class GrocerySection extends StatelessWidget {
  final String title;
  final List<GroceryItem> items;
  const GrocerySection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),

            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),

              child: Text('${items.length}'),
            ),
          ],
        ),

        AppSpacing.verticalMD,

        Column(
          children: items.map((item) {
            return GroceryItemCard(item: item);
          }).toList(),
        ),
      ],
    );
  }
}
