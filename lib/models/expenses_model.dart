import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum ExpenseCategory { food, travel, leisure, work }

const expenseCategoryIcons = {
  ExpenseCategory.food: Icons.lunch_dining,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.work: Icons.work,
  ExpenseCategory.leisure: Icons.movie,
};

class ExpensesModel {
  ExpensesModel(this.category,
      {required this.amount, required this.title, required this.date})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<ExpensesModel> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final ExpenseCategory category;
  final List<ExpensesModel> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
