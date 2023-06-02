import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.leisure: (Icons.movie),
  Category.work: (Icons.work),
  Category.food: (Icons.dinner_dining),
  Category.travel: (Icons.flight)
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get dateFormatter {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenseList, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) :
      expenseList = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenseList;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
