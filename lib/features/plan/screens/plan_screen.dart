import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  void pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Meal Plan',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        Text(
                          DateFormat('MMMM yyyy').format(selectedDate),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: pickDate,
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
