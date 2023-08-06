import 'package:flutter/material.dart';
import 'package:own_app3/widget/chart/chart.dart';
import 'package:own_app3/widget/expense_list/expenses_list.dart';
import 'package:own_app3/models/expense.dart';
import 'package:own_app3/widget/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        amount: 499,
        title: 'Course',
        date: DateTime.now(),
        category: Category.study),
    Expense(
        amount: 549,
        title: 'Movie',
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpanse(_addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Expense Deleted'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(
                () {
                  _registeredExpense.insert(expenseIndex, expense);
                },
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyMsg = const Center(
      child: Text('No Expense Found, Please Start Adding'),
    );
    if (_registeredExpense.isNotEmpty) {
      emptyMsg = ExpensesList(
        _registeredExpense,
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "ExpenseTracker",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 12, 8, 88),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverLay,
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ]),
      body: Column(children: [
        Chart(expenses: _registeredExpense),
        Expanded(child: emptyMsg),
      ]),
    );
  }
}
