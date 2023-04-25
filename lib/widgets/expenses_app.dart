import 'package:flutter/material.dart';
import 'package:flutter_application_5/chart.dart';

import 'package:flutter_application_5/widgets/expenses_list.dart';
import 'package:flutter_application_5/widgets/new_expense.dart';
import '../models/expenses_model.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesApp();
  }
}

class _ExpensesApp extends State<ExpensesApp> {
  final List<ExpensesModel> _expenseData = [
    ExpensesModel(ExpenseCategory.food,
        amount: 10.99, title: 'Clothes', date: DateTime.now())
  ];

  void _openOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: addExpenses));
  }

  void addExpenses(ExpensesModel expense) {
    setState(() {
      _expenseData.add(expense);
    });
  }

  void removeExpenses(ExpensesModel expense) {
    final expenseIndex = _expenseData.indexOf(expense);
    setState(() {
      _expenseData.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Expense deleted.'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _expenseData.insert(expenseIndex, expense);
                });
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.height);

    Widget mainContent = const Center(
      child: Text('No expanses found. start adding some!'),
    );

    if (_expenseData.isNotEmpty) {
      mainContent = ExpensesList(
        expenseList: _expenseData,
        onRemoveExpense: removeExpenses,
      );
    }
    return Scaffold(
        appBar: AppBar(
          // in ios centered title is default so to change that use center title as false 
          // centerTitle: false,
          title: const Text('Flutter Expense Tracker'),
          actions: [
            IconButton(
              onPressed: _openOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _expenseData),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _expenseData)),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
