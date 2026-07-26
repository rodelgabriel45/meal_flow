import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:mealflow/features/grocery/widgets/grocery_filter_bar.dart';
import 'package:mealflow/features/grocery/widgets/grocery_header.dart';
import 'package:mealflow/features/grocery/widgets/grocery_section.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = context.watch<GroceryProvider>().sections;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            children: [
              GroceryHeader(),

              AppSpacing.verticalLG,

              GroceryFilterBar(),

              AppSpacing.verticalLG,

              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final section = sections[index];

                    return GrocerySection(
                      title: section.title,
                      items: section.items,
                    );
                  },
                  separatorBuilder: (_, _) => AppSpacing.verticalLG,
                  itemCount: sections.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
