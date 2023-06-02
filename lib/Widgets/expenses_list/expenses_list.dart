import 'package:expense_tracker/Widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/models/ExpensesModel.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenseList, required this.onExpenseRemoved});

  final List<Expense> expenseList;
  final void Function(Expense expense) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          onExpenseRemoved(expenseList[index]);
        },
        key: ValueKey(expenseList[index]),
        child: ExpenseItem(expense: expenseList[index]),
      ),
    );
  }
}
