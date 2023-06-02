// To add Expenses widget
import 'package:expense_tracker/Widgets/chart/chart.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/ExpensesModel.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<StatefulWidget> {
  final List<Expense> _addedExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void addNewExpense(Expense expense) {
    setState(() {
      _addedExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final removedExpenseIndex = _addedExpenses.indexOf(expense);

    setState(() {
      _addedExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _addedExpenses.insert(removedExpenseIndex, expense);
              });
            }),
      ),
    );
  }

  void addAction() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: addNewExpense));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("No expense added, start by adding one"));

    if (_addedExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenseList: _addedExpenses, onExpenseRemoved: removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter ExpenseTracker"),
        actions: [
          IconButton(onPressed: addAction, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _addedExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
