import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/plan/widgets/meal_plan_section.dart';
import 'package:mealflow/features/plan/widgets/week_calendar.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            children: [
              SizedBox(
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Meal Plan',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          //
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                  ],
                ),
              ),

              AppSpacing.verticalMD,

              WeekCalendar(
                selectedDate: selectedDate,
                onDateSelected: onDateSelected,
              ),

              AppSpacing.verticalMD,

              MealPlanSection(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}
