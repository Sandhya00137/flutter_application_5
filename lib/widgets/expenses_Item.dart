import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/expenses_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expenseItem, super.key});

  final ExpensesModel expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(expenseCategoryIcons[expenseItem.category]),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(expenseItem.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
