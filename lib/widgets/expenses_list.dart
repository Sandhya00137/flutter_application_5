import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/expenses_model.dart';
import 'package:flutter_application_5/widgets/expenses_Item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenseList, required this.onRemoveExpense});

  final List<ExpensesModel> expenseList;
  final void Function(ExpensesModel expensesModel) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenseList[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenseList[index]);
            },
            child: ExpenseItem(
              expenseItem: expenseList[index],
            ),
          );
        });
  }
}
