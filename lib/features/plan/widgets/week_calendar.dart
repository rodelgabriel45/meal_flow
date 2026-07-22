import 'package:flutter/material.dart';
import 'package:mealflow/features/plan/widgets/day_item.dart';

class WeekCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  const WeekCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final monday = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );

    bool isSameDay(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    return SizedBox(
      height: 65,
      child: Row(
        children: List.generate(7, (index) {
          final date = monday.add(Duration(days: index));

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: DayItem(
                date: date,
                isSelected: isSameDay(date, selectedDate),
                onTap: onDateSelected,
              ),
            ),
          );
        }),
      ),
    );
  }
}
