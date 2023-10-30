import 'package:flutter/material.dart';
import 'package:sas_lab_four/models/expense.dart';
import 'package:sas_lab_four/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.memberExpenses}); // Змінено параметр

  final List<Expense>
      memberExpenses; // Тепер це буде список витрат обраного члена сім'ї

  List<ExpenseBucket> get buckets {
    List<ExpenseBucket> memberBuckets = [
      ExpenseBucket.forCategory(memberExpenses, Category.food),
      ExpenseBucket.forCategory(memberExpenses, Category.leisure),
      ExpenseBucket.forCategory(memberExpenses, Category.travel),
      ExpenseBucket.forCategory(memberExpenses, Category.work),
      ExpenseBucket.forCategory(memberExpenses, Category.tiktok),
    ];

    return memberBuckets;
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpenses == 0 || maxTotalExpense == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
