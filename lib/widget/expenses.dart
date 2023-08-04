import 'package:flutter/material.dart';
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
    Expense(
        amount: 180,
        title: 'Hangout',
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        amount: 69,
        title: 'Burger',
        date: DateTime.now(),
        category: Category.food),
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpanse());
  }

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: ExpensesList
          (_registeredExpense),
        ),
      ]),
    );
  }
}
